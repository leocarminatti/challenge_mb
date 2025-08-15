import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_asset.dart';
import 'package:challenge_mb/src/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchange_assets_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late GetExchangeAssetsUseCase useCase;
  late ExchangeRepository mockRepository;

  setUp(() {
    mockRepository = TestMocks.createMockExchangeRepository();
    useCase = GetExchangeAssetsUseCase(mockRepository);
  });

  group('GetExchangeAssetsUseCase', () {
    test('deve retornar assets da exchange do repositório', () async {
      // Arrange
      const exchangeId = 'binance';
      when(
        () => mockRepository.getExchangeAssets(exchangeId),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchangeAssets));

      // Act
      final result = await useCase(exchangeId);

      // Assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Não deveria retornar falha'), (assets) {
        expect(assets, isA<List<ExchangeAsset>>());
        expect(assets.length, EntitiesMocks.exchangeAssets.length);
        expect(
          assets[0].walletAddress,
          EntitiesMocks.exchangeAssets[0].walletAddress,
        );
        expect(assets[0].balance, EntitiesMocks.exchangeAssets[0].balance);
        expect(
          assets[0].currency.symbol,
          EntitiesMocks.exchangeAssets[0].currency.symbol,
        );
        expect(
          assets[1].walletAddress,
          EntitiesMocks.exchangeAssets[1].walletAddress,
        );
        expect(assets[1].balance, EntitiesMocks.exchangeAssets[1].balance);
        expect(
          assets[1].currency.symbol,
          EntitiesMocks.exchangeAssets[1].currency.symbol,
        );
      });

      verify(() => mockRepository.getExchangeAssets(exchangeId)).called(1);
    });

    test('deve retornar falha quando repositório falha', () async {
      // Arrange
      const exchangeId = 'binance';
      when(
        () => mockRepository.getExchangeAssets(exchangeId),
      ).thenAnswer((_) async => Left(ServerFailure('Repository error')));

      // Act
      final result = await useCase(exchangeId);

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Repository error');
      }, (assets) => fail('Não deveria retornar sucesso'));

      verify(() => mockRepository.getExchangeAssets(exchangeId)).called(1);
    });

    test(
      'deve retornar lista vazia quando repositório retorna lista vazia',
      () async {
        // Arrange
        const exchangeId = 'empty-exchange';
        when(
          () => mockRepository.getExchangeAssets(exchangeId),
        ).thenAnswer((_) async => const Right([]));

        // Act
        final result = await useCase(exchangeId);

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (assets) {
          expect(assets, isA<List<ExchangeAsset>>());
          expect(assets.isEmpty, true);
        });

        verify(() => mockRepository.getExchangeAssets(exchangeId)).called(1);
      },
    );

    test('deve retornar falha quando exchangeId está vazio', () async {
      // Arrange
      const exchangeId = '';
      when(() => mockRepository.getExchangeAssets(exchangeId)).thenAnswer(
        (_) async => Left(ServerFailure('ID da exchange não pode estar vazio')),
      );

      // Act
      final result = await useCase(exchangeId);

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(
          failure.message,
          contains('ID da exchange não pode estar vazio'),
        );
      }, (assets) => fail('Não deveria retornar sucesso'));

      verify(() => mockRepository.getExchangeAssets(exchangeId)).called(1);
    });

    test('deve retornar falha quando exchangeId é nulo', () async {
      // Arrange
      const exchangeId = '';
      when(() => mockRepository.getExchangeAssets(exchangeId)).thenAnswer(
        (_) async => Left(ServerFailure('ID da exchange não pode estar vazio')),
      );

      // Act
      final result = await useCase(exchangeId);

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(
          failure.message,
          contains('ID da exchange não pode estar vazio'),
        );
      }, (assets) => fail('Não deveria retornar sucesso'));

      verify(() => mockRepository.getExchangeAssets(exchangeId)).called(1);
    });
  });
}
