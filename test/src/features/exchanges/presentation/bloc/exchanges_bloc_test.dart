import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchanges_by_ids_usecase.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_event.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late ExchangesBloc bloc;
  late GetExchangesByIdsUseCase mockGetExchangesByIdsUseCase;

  setUp(() {
    mockGetExchangesByIdsUseCase =
        TestMocks.createMockGetExchangesByIdsUseCase();
    bloc = ExchangesBloc(mockGetExchangesByIdsUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('ExchangesBloc', () {
    test('estado inicial deve ser ExchangesInitial', () {
      expect(bloc.state, isA<ExchangesInitial>());
    });

    blocTest<ExchangesBloc, ExchangesState>(
      'deve emitir [ExchangesLoading, ExchangesLoaded] quando LoadExchanges é adicionado com sucesso',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Right(EntitiesMocks.exchanges));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadExchanges()),
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesLoaded>()],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(1);
      },
    );

    blocTest<ExchangesBloc, ExchangesState>(
      'deve emitir [ExchangesLoading, ExchangesError] quando LoadExchanges falha',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => Left(ServerFailure('API Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadExchanges()),
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesError>()],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(1);
      },
    );

    blocTest<ExchangesBloc, ExchangesState>(
      'deve emitir [ExchangesLoadingMore, ExchangesLoaded] quando LoadMoreExchanges é adicionado com sucesso',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((invocation) async {
          final start = invocation.namedArguments[const Symbol('start')] as int;
          if (start == 1) {
            return Right(EntitiesMocks.exchanges.take(15).toList());
          } else {
            return Right(EntitiesMocks.exchanges.skip(15).toList());
          }
        });
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const LoadExchanges());
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const LoadMoreExchanges());
      },
      expect: () => [
        isA<ExchangesLoading>(),
        isA<ExchangesLoaded>(),
        isA<ExchangesLoadingMore>(),
        isA<ExchangesLoaded>(),
      ],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(2);
      },
    );

    blocTest<ExchangesBloc, ExchangesState>(
      'deve emitir [ExchangesLoadingMore, ExchangesError] quando LoadMoreExchanges falha',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((invocation) async {
          final start = invocation.namedArguments[const Symbol('start')] as int;
          if (start == 1) {
            return Right(EntitiesMocks.exchanges.take(15).toList());
          } else {
            return Left(ServerFailure('API Error'));
          }
        });
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const LoadExchanges());
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const LoadMoreExchanges());
      },
      expect: () => [
        isA<ExchangesLoading>(),
        isA<ExchangesLoaded>(),
        isA<ExchangesLoadingMore>(),
        isA<ExchangesError>(),
      ],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(2);
      },
    );

    blocTest<ExchangesBloc, ExchangesState>(
      'não deve carregar mais exchanges quando já está carregando',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (_) async => Right(EntitiesMocks.exchanges.take(10).toList()),
        );
        return bloc;
      },
      act: (bloc) {
        bloc.add(const LoadExchanges());
        bloc.add(const LoadMoreExchanges());
      },
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesLoaded>()],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(1);
      },
    );

    blocTest<ExchangesBloc, ExchangesState>(
      'não deve carregar mais exchanges quando já chegou ao máximo',
      build: () {
        when(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (_) async => Right(EntitiesMocks.exchanges.take(10).toList()),
        );
        return bloc;
      },
      act: (bloc) {
        bloc.add(const LoadExchanges());
        bloc.add(const LoadMoreExchanges());
      },
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesLoaded>()],
      verify: (_) {
        verify(
          () => mockGetExchangesByIdsUseCase(
            start: any(named: 'start'),
            limit: any(named: 'limit'),
          ),
        ).called(1);
      },
    );
  });
}
