import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/domain/entities/exchange_map.dart';
import 'package:challenge_mb/src/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchange_map_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late GetExchangeMapUseCase useCase;
  late ExchangeRepository mockRepository;

  setUp(() {
    mockRepository = TestMocks.createMockExchangeRepository();
    useCase = GetExchangeMapUseCase(mockRepository);
  });

  group('GetExchangeMapUseCase', () {
    test('deve retornar lista de exchanges do repositório', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(),
      ).thenAnswer((_) async => Right(EntitiesMocks.exchangeMaps));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Não deveria retornar falha'), (exchanges) {
        expect(exchanges, isA<List<ExchangeMap>>());
        expect(exchanges.length, EntitiesMocks.exchangeMaps.length);
        expect(exchanges[0].id, EntitiesMocks.exchangeMaps[0].id);
        expect(exchanges[1].id, EntitiesMocks.exchangeMaps[1].id);
        expect(exchanges[2].id, EntitiesMocks.exchangeMaps[2].id);
      });

      verify(() => mockRepository.getExchangeMap()).called(1);
    });

    test('deve retornar falha quando repositório falha', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeMap(),
      ).thenAnswer((_) async => Left(ServerFailure('Repository error')));

      // Act
      final result = await useCase();

      // Assert
      expect(result.isLeft(), true);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Repository error');
      }, (exchanges) => fail('Não deveria retornar sucesso'));

      verify(() => mockRepository.getExchangeMap()).called(1);
    });

    test(
      'deve retornar lista vazia quando repositório retorna lista vazia',
      () async {
        // Arrange
        when(
          () => mockRepository.getExchangeMap(),
        ).thenAnswer((_) async => const Right([]));

        // Act
        final result = await useCase();

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Não deveria retornar falha'), (
          exchanges,
        ) {
          expect(exchanges, isA<List<ExchangeMap>>());
          expect(exchanges.isEmpty, true);
        });

        verify(() => mockRepository.getExchangeMap()).called(1);
      },
    );
  });
}
