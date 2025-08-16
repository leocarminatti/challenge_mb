import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_mb/core/infra/errors/failures.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchange_assets_stream_usecase.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_event.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late ExchangeDetailsBloc bloc;
  late GetExchangeAssetsStreamUseCase mockGetExchangeAssetsStreamUseCase;

  setUp(() {
    mockGetExchangeAssetsStreamUseCase =
        TestMocks.createMockGetExchangeAssetsStreamUseCase();
    bloc = ExchangeDetailsBloc(mockGetExchangeAssetsStreamUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('ExchangeDetailsBloc', () {
    test('estado inicial deve ser ExchangeDetailsInitial', () {
      expect(bloc.state, isA<ExchangeDetailsInitial>());
    });

    blocTest<ExchangeDetailsBloc, ExchangeDetailsState>(
      'deve emitir [ExchangeDetailsLoadedWithLoadingAssets, ExchangeDetailsLoaded] quando LoadExchangeDetails é adicionado com sucesso',
      build: () {
        when(
          () => mockGetExchangeAssetsStreamUseCase(any()),
        ).thenAnswer((_) => Stream.value(Right(EntitiesMocks.exchangeAssets)));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadExchangeDetails(EntitiesMocks.exchanges[0])),
      expect: () => [
        isA<ExchangeDetailsLoadedWithLoadingAssets>(),
        isA<ExchangeDetailsLoaded>(),
      ],
      verify: (_) {
        verify(() => mockGetExchangeAssetsStreamUseCase(any())).called(1);
      },
    );

    blocTest<ExchangeDetailsBloc, ExchangeDetailsState>(
      'deve emitir [ExchangeDetailsLoadedWithLoadingAssets, ExchangeDetailsError] quando LoadExchangeDetails falha',
      build: () {
        when(
          () => mockGetExchangeAssetsStreamUseCase(any()),
        ).thenAnswer((_) => Stream.value(Left(ServerFailure('API Error'))));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadExchangeDetails(EntitiesMocks.exchanges[0])),
      expect: () => [
        isA<ExchangeDetailsLoadedWithLoadingAssets>(),
        isA<ExchangeDetailsError>(),
      ],
      verify: (_) {
        verify(() => mockGetExchangeAssetsStreamUseCase(any())).called(1);
      },
    );

    blocTest<ExchangeDetailsBloc, ExchangeDetailsState>(
      'deve emitir [ExchangeDetailsLoadedWithLoadingAssets, ExchangeDetailsLoaded] quando LoadExchangeDetails é adicionado com lista vazia',
      build: () {
        when(
          () => mockGetExchangeAssetsStreamUseCase(any()),
        ).thenAnswer((_) => Stream.value(const Right([])));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadExchangeDetails(EntitiesMocks.exchanges[0])),
      expect: () => [
        isA<ExchangeDetailsLoadedWithLoadingAssets>(),
        isA<ExchangeDetailsLoaded>(),
      ],
      verify: (_) {
        verify(() => mockGetExchangeAssetsStreamUseCase(any())).called(1);
      },
    );

    blocTest<ExchangeDetailsBloc, ExchangeDetailsState>(
      'deve carregar mais assets quando LoadMoreAssets é adicionado',
      build: () {
        when(
          () => mockGetExchangeAssetsStreamUseCase(any()),
        ).thenAnswer((_) => Stream.value(Right(EntitiesMocks.exchangeAssets)));
        return bloc;
      },
      act: (bloc) async {
        bloc.add(LoadExchangeDetails(EntitiesMocks.exchanges[0]));
        await Future.delayed(const Duration(milliseconds: 200));
        bloc.add(LoadMoreAssets(EntitiesMocks.exchanges[0].id));
      },
      expect: () => [
        isA<ExchangeDetailsLoadedWithLoadingAssets>(),
        isA<ExchangeDetailsLoaded>(),
      ],
      verify: (_) {
        verify(() => mockGetExchangeAssetsStreamUseCase(any())).called(1);
      },
    );
  });
}
