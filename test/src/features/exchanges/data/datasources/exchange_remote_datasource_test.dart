import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/core/infra/http/http_client.dart';
import 'package:challenge_mb/core/infra/http/http_error.dart';
import 'package:challenge_mb/src/features/exchanges/data/datasources/exchange_remote_datasource.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_asset_model.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_map_model.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late ExchangeRemoteDataSourceImpl dataSource;
  late HttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = TestMocks.createMockHttpClient();
    dataSource = ExchangeRemoteDataSourceImpl(mockHttpClient);
  });

  group('ExchangeRemoteDataSourceImpl', () {
    group('getExchangeMap', () {
      test('deve retornar lista de exchanges com sucesso', () async {
        // Arrange

        when(
          () => mockHttpClient.get(
            '/exchange/map',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            data: JsonMocks.exchangeMapResponse,
            statusCode: 200,
            headers: {},
          ),
        );

        // Act
        final result = await dataSource.getExchangeMap();

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchanges,
        ) {
          expect(exchanges, isA<List<ExchangeMapModel>>());
          expect(exchanges.length, 3);
          expect(exchanges[0].id, 1);
          expect(exchanges[1].id, 2);
          expect(exchanges[2].id, 3);
        });

        verify(
          () => mockHttpClient.get(
            '/exchange/map',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
      });

      test('deve retornar falha quando API retorna erro', () async {
        // Arrange
        when(
          () => mockHttpClient.get(
            '/exchange/map',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          HttpError(statusCode: 500, data: 'Server Error', headers: {}),
        );

        // Act
        final result = await dataSource.getExchangeMap();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('Server Error'));
        }, (exchanges) => fail('Não deveria retornar sucesso'));
      });

      test('deve retornar falha quando dados estão malformados', () async {
        // Arrange

        when(
          () => mockHttpClient.get(
            '/exchange/map',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            data: JsonMocks.malformedResponse,
            statusCode: 200,
            headers: {},
          ),
        );

        // Act
        final result = await dataSource.getExchangeMap();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<DataParsingFailure>());
          expect(failure.message, contains('Erro ao fazer parse'));
        }, (exchanges) => fail('Não deveria retornar sucesso'));
      });
    });

    group('getExchangeDetails', () {
      test('deve retornar detalhes da exchange com sucesso', () async {
        // Arrange
        const exchangeId = 'binance';

        when(
          () => mockHttpClient.get(
            '/exchange/info',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            data: JsonMocks.exchangeDetailsResponse,
            statusCode: 200,
            headers: {},
          ),
        );

        // Act
        final result = await dataSource.getExchangeDetails(exchangeId);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchange,
        ) {
          expect(exchange, isA<ExchangeModel>());
          expect(exchange.id, '1');
          expect(exchange.name, 'Binance');
          expect(exchange.logo, 'https://example.com/binance.png');
          expect(exchange.description, 'Leading cryptocurrency exchange');
          expect(exchange.spotVolumeUsd, 1000000000.0);
        });

        verify(
          () => mockHttpClient.get(
            '/exchange/info',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
      });

      test('deve retornar falha quando exchange não encontrada', () async {
        // Arrange
        const exchangeId = 'invalid-exchange';
        when(
          () => mockHttpClient.get(
            '/exchange/info',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          HttpError(statusCode: 404, data: 'Exchange not found', headers: {}),
        );

        // Act
        final result = await dataSource.getExchangeDetails(exchangeId);

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('Exchange not found'));
        }, (exchange) => fail('Não deveria retornar sucesso'));
      });
    });

    group('getMultipleExchangeDetails', () {
      test('deve retornar múltiplas exchanges com sucesso', () async {
        // Arrange
        final exchangeIds = ['binance', 'coinbase'];

        when(
          () => mockHttpClient.get(
            '/exchange/info',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            data: JsonMocks.exchangeDetailsResponse,
            statusCode: 200,
            headers: {},
          ),
        );

        // Act
        final result = await dataSource.getMultipleExchangeDetails(exchangeIds);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchanges,
        ) {
          expect(exchanges, isA<List<ExchangeModel>>());
          expect(exchanges.length, 2);
          expect(exchanges[0].id, '1');
          expect(exchanges[0].name, 'Binance');
          expect(exchanges[1].id, '2');
          expect(exchanges[1].name, 'Coinbase');
        });
      });
    });

    group('getExchangeAssets', () {
      test('deve retornar assets da exchange com sucesso', () async {
        // Arrange
        const exchangeId = 'binance';

        when(
          () => mockHttpClient.get(
            '/exchange/assets',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            data: JsonMocks.exchangeAssetsResponse,
            statusCode: 200,
            headers: {},
          ),
        );

        // Act
        final result = await dataSource.getExchangeAssets(exchangeId);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (assets) {
          expect(assets, isA<List<ExchangeAssetModel>>());
          expect(assets.length, 3);
          expect(assets[0].walletAddress, '0x1234567890abcdef');
          expect(assets[0].balance, 1000.5);
          expect(assets[0].platform?.symbol, 'BTC');
          expect(assets[0].currency.symbol, 'BTC');
          expect(assets[1].walletAddress, '0xabcdef1234567890');
          expect(assets[1].balance, 5000.0);
          expect(assets[1].platform, null);
          expect(assets[1].currency.symbol, 'ETH');
          expect(assets[2].walletAddress, '0x9876543210fedcba');
          expect(assets[2].balance, 25000.0);
          expect(assets[2].platform?.symbol, 'XRP');
          expect(assets[2].currency.symbol, 'XRP');
        });

        verify(
          () => mockHttpClient.get(
            '/exchange/assets',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).called(1);
      });

      test('deve retornar falha quando API retorna erro', () async {
        // Arrange
        const exchangeId = 'binance';
        when(
          () => mockHttpClient.get(
            '/exchange/assets',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          HttpError(statusCode: 403, data: 'Access denied', headers: {}),
        );

        // Act
        final result = await dataSource.getExchangeAssets(exchangeId);

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('Access denied'));
        }, (assets) => fail('Não deveria retornar sucesso'));
      });
    });
  });
}
