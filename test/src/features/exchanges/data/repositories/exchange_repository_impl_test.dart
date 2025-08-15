import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/data/datasources/exchange_remote_datasource.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_asset_model.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_map_model.dart';
import 'package:challenge_mb/src/features/exchanges/data/models/exchange_model.dart';
import 'package:challenge_mb/src/features/exchanges/data/repositories/exchange_repository_impl.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_asset.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_map.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late ExchangeRepositoryImpl repository;
  late ExchangeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = TestMocks.createMockExchangeRemoteDataSource();
    repository = ExchangeRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('ExchangeRepositoryImpl', () {
    group('getExchangeMap', () {
      test('deve retornar lista de exchanges do datasource remoto', () async {
        // Arrange
        final testExchangeMapModel = const ExchangeMapModel(id: 1);
        when(
          () => mockRemoteDataSource.getExchangeMap(any(), any()),
        ).thenAnswer((_) async => Right([testExchangeMapModel]));

        // Act
        final result = await repository.getExchangeMap();

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchanges,
        ) {
          expect(exchanges, isA<List<ExchangeMap>>());
          expect(exchanges.length, 1);
          expect(exchanges.first.id, '1');
        });
        verify(
          () => mockRemoteDataSource.getExchangeMap(any(), any()),
        ).called(1);
      });

      test('deve retornar falha quando datasource falha', () async {
        // Arrange
        when(
          () => mockRemoteDataSource.getExchangeMap(any(), any()),
        ).thenAnswer((_) async => Left(ServerFailure('API Error')));

        // Act
        final result = await repository.getExchangeMap();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'API Error');
        }, (exchanges) => fail('Não deveria retornar sucesso'));
      });
    });

    group('getExchangeDetails', () {
      test('deve retornar detalhes da exchange do datasource remoto', () async {
        // Arrange
        const exchangeId = 'test-id';
        final testExchangeModel = ExchangeModel(
          id: 'test-id',
          logo: 'https://example.com/logo.png',
          name: 'Test Exchange',
        );
        when(
          () => mockRemoteDataSource.getExchangeDetails(exchangeId),
        ).thenAnswer((_) async => Right(testExchangeModel));

        // Act
        final result = await repository.getExchangeDetails(exchangeId);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchange,
        ) {
          expect(exchange, isA<Exchange>());
          expect(exchange.id, 'test-id');
        });
        verify(
          () => mockRemoteDataSource.getExchangeDetails(exchangeId),
        ).called(1);
      });

      test('deve retornar falha quando datasource falha', () async {
        // Arrange
        const exchangeId = 'test-id';
        when(
          () => mockRemoteDataSource.getExchangeDetails(exchangeId),
        ).thenAnswer((_) async => Left(ServerFailure('API Error')));

        // Act
        final result = await repository.getExchangeDetails(exchangeId);

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'API Error');
        }, (exchange) => fail('Não deveria retornar sucesso'));
      });
    });

    group('getMultipleExchangeDetails', () {
      test('deve retornar múltiplas exchanges do datasource remoto', () async {
        // Arrange
        final exchangeIds = ['test-id-1', 'test-id-2'];
        final testExchangeModel = ExchangeModel(
          id: 'test-id',
          logo: 'https://example.com/logo.png',
          name: 'Test Exchange',
        );
        when(
          () => mockRemoteDataSource.getMultipleExchangeDetails(exchangeIds),
        ).thenAnswer((_) async => Right([testExchangeModel]));

        // Act
        final result = await repository.getMultipleExchangeDetails(exchangeIds);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchanges,
        ) {
          expect(exchanges, isA<List<Exchange>>());
          expect(exchanges.length, 1);
          expect(exchanges.first.id, 'test-id');
        });
        verify(
          () => mockRemoteDataSource.getMultipleExchangeDetails(exchangeIds),
        ).called(1);
      });
    });

    group('getExchangeCurrencies', () {
      test('deve retornar moedas da exchange do datasource remoto', () async {
        // Arrange
        const exchangeId = 'test-id';
        final testExchangeAssetModel = ExchangeAssetModel(
          walletAddress: '0x1234567890',
          balance: 1000.0,
          platform: PlatformModel(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
          currency: CurrencyModel(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
        );
        when(
          () => mockRemoteDataSource.getExchangeAssets(exchangeId),
        ).thenAnswer((_) async => Right([testExchangeAssetModel]));

        // Act
        final result = await repository.getExchangeAssets(exchangeId);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (assets) {
          expect(assets, isA<List<ExchangeAsset>>());
          expect(assets.length, 1);
          expect(assets.first.walletAddress, '0x1234567890');
          expect(assets.first.balance, 1000.0);
          expect(assets.first.platform?.cryptoId, 1);
          expect(assets.first.platform?.symbol, 'BTC');
          expect(assets.first.platform?.name, 'Bitcoin');
          expect(assets.first.currency.symbol, 'BTC');
          expect(assets.first.currency.cryptoId, 1);
          expect(assets.first.currency.name, 'Bitcoin');
        });
        verify(
          () => mockRemoteDataSource.getExchangeAssets(exchangeId),
        ).called(1);
      });

      test('deve retornar falha quando datasource falha', () async {
        // Arrange
        const exchangeId = 'test-id';
        when(
          () => mockRemoteDataSource.getExchangeAssets(exchangeId),
        ).thenAnswer((_) async => Left(ServerFailure('API Error')));

        // Act
        final result = await repository.getExchangeAssets(exchangeId);

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'API Error');
        }, (assets) => fail('Não deveria retornar sucesso'));
      });
    });
  });
}
