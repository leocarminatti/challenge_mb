import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange.dart';
import 'package:challenge_mb/src/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchanges_by_ids_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late GetExchangesByIdsUseCase useCase;
  late ExchangeRepository mockRepository;

  setUp(() {
    mockRepository = TestMocks.createMockExchangeRepository();
    useCase = GetExchangesByIdsUseCase(mockRepository);
  });

  group('GetExchangesByIdsUseCase', () {
    test('deve retornar exchanges por IDs com sucesso', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(any(), any()),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchangeMaps));
      when(
        () => mockRepository.getMultipleExchangeDetails(any()),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchanges));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Não deveria retornar falha'), (exchanges) {
        expect(exchanges, isA<List<Exchange>>());
        expect(exchanges.length, EntitiesMocks.exchanges.length);
        expect(exchanges[0].id, EntitiesMocks.exchanges[0].id);
        expect(exchanges[0].name, EntitiesMocks.exchanges[0].name);
        expect(exchanges[1].id, EntitiesMocks.exchanges[1].id);
        expect(exchanges[1].name, EntitiesMocks.exchanges[1].name);
      });

      verify(() => mockRepository.getExchangeMap(any(), any())).called(1);
      verify(() => mockRepository.getMultipleExchangeDetails(any())).called(1);
    });

    test('deve retornar falha quando getExchangeMap falha', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(any(), any()),
      ).thenAnswer((_) async => Left(ServerFailure('Repository error')));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Repository error');
      }, (exchanges) => fail('Não deveria retornar sucesso'));

      verify(() => mockRepository.getExchangeMap(any(), any())).called(1);
      verifyNever(() => mockRepository.getMultipleExchangeDetails(any()));
    });

    test(
      'deve retornar falha quando getMultipleExchangeDetails falha',
      () async {
        // Arrange
        when(
          () => mockRepository.getExchangeMap(any(), any()),
        ).thenAnswer((_) async => Right(EntitiesMocks.exchangeMaps));
        when(
          () => mockRepository.getMultipleExchangeDetails(any()),
        ).thenAnswer((_) async => Left(ServerFailure('Details error')));

        // Act
        final result = await useCase();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Details error');
        }, (exchanges) => fail('Não deveria retornar sucesso'));

        verify(() => mockRepository.getExchangeMap(any(), any())).called(1);
        verify(
          () => mockRepository.getMultipleExchangeDetails(any()),
        ).called(1);
      },
    );

    test('deve retornar lista vazia quando não há exchanges', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(any(), any()),
      ).thenAnswer((_) async => const Right([]));
      when(
        () => mockRepository.getMultipleExchangeDetails(any()),
      ).thenAnswer((_) async => const Right([]));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Não deveria retornar falha'), (exchanges) {
        expect(exchanges, isA<List<Exchange>>());
        expect(exchanges.isEmpty, true);
      });

      verify(() => mockRepository.getExchangeMap(any(), any())).called(1);
      verify(() => mockRepository.getMultipleExchangeDetails(any())).called(1);
    });

    test('deve usar parâmetros start e limit corretos', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(any(), any()),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchangeMaps));
      when(
        () => mockRepository.getMultipleExchangeDetails(any()),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchanges));

      // Act
      await useCase(start: 5, limit: 10);

      // Assert
      verify(() => mockRepository.getExchangeMap(5, 10)).called(1);
      verify(() => mockRepository.getMultipleExchangeDetails(any())).called(1);
    });

    test(
      'deve usar valores padrão quando start e limit não são fornecidos',
      () async {
        // Arrange
        when(
          () => mockRepository.getExchangeMap(any(), any()),
        ).thenAnswer((_) async => Right(EntitiesMocks.exchangeMaps));
        when(
          () => mockRepository.getMultipleExchangeDetails(any()),
        ).thenAnswer((_) async => Right(EntitiesMocks.exchanges));

        // Act
        await useCase();

        // Assert
        verify(() => mockRepository.getExchangeMap(null, null)).called(1);
        verify(
          () => mockRepository.getMultipleExchangeDetails(any()),
        ).called(1);
      },
    );
  });
}
