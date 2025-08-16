import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeDetailsBloc extends Mock implements ExchangeDetailsBloc {}

void main() {
  group('ExchangeAssetsList', () {
    late MockExchangeDetailsBloc mockBloc;
    late List<ExchangeAsset> mockAssets;

    setUp(() {
      mockBloc = MockExchangeDetailsBloc();
      mockAssets = [
        ExchangeAsset(
          walletAddress: '0x1234567890abcdef',
          balance: 1000.5,
          platform: null,
          currency: AssetCurrency(
            cryptoId: 1,
            priceUsd: 50000.0,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
        ),
        ExchangeAsset(
          walletAddress: '0xabcdef1234567890',
          balance: 5000.0,
          platform: null,
          currency: AssetCurrency(
            cryptoId: 1027,
            priceUsd: 3000.0,
            symbol: 'ETH',
            name: 'Ethereum',
          ),
        ),
      ];
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: CustomScrollView(slivers: [ExchangeAssetsList(bloc: mockBloc)]),
        ),
        debugShowCheckedModeBanner: false,
      );
    }

    testWidgets('deve renderizar loading inicial', (tester) async {
      when(
        () => mockBloc.stream,
      ).thenAnswer((_) => Stream.value(ExchangeDetailsInitial()));
      when(() => mockBloc.state).thenReturn(ExchangeDetailsInitial());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar loading quando carregando', (tester) async {
      when(
        () => mockBloc.stream,
      ).thenAnswer((_) => Stream.value(ExchangeDetailsLoading()));
      when(() => mockBloc.state).thenReturn(ExchangeDetailsLoading());

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar erro quando falhar', (tester) async {
      when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(
          const ExchangeDetailsError('Erro ao carregar os assets'),
        ),
      );
      when(
        () => mockBloc.state,
      ).thenReturn(const ExchangeDetailsError('Erro ao carregar os assets'));

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangesShowError), findsOneWidget);
      expect(find.text('Erro: Erro ao carregar os assets'), findsOneWidget);
    });

    testWidgets('deve renderizar loading de assets quando carregando assets', (
      tester,
    ) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoadedWithLoadingAssets(
        ExchangeDetailsWithAssets(exchange: exchange, assets: []),
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar assets quando carregados', (tester) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoaded(
        ExchangeDetailsWithAssets(exchange: exchange, assets: mockAssets),
        allAssets: mockAssets,
        hasMoreAssets: false,
        currentPage: 1,
        assetsPerPage: 20,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Assets da Exchange (2)'), findsOneWidget);
      expect(find.byType(ExchangeAssetRow), findsNWidgets(2));
    });

    testWidgets('deve mostrar contador correto de assets', (tester) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoaded(
        ExchangeDetailsWithAssets(exchange: exchange, assets: mockAssets),
        allAssets: mockAssets,
        hasMoreAssets: false,
        currentPage: 1,
        assetsPerPage: 20,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Assets da Exchange (2)'), findsOneWidget);
    });

    testWidgets(
      'deve renderizar botão de carregar mais quando há mais assets',
      (tester) async {
        final exchange = Exchange(
          id: '1',
          name: 'Binance',
          logo: null,
          description: 'Leading cryptocurrency exchange',
          dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
          spotVolumeUsd: 15000000.0,
        );

        final state = ExchangeDetailsLoaded(
          ExchangeDetailsWithAssets(exchange: exchange, assets: mockAssets),
          allAssets: mockAssets,
          hasMoreAssets: true,
          currentPage: 1,
          assetsPerPage: 20,
        );

        when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
        when(() => mockBloc.state).thenReturn(state);

        await tester.pumpWidget(createTestWidget());

        expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);
      },
    );

    testWidgets('deve aplicar tema correto ao título', (tester) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoaded(
        ExchangeDetailsWithAssets(exchange: exchange, assets: mockAssets),
        allAssets: mockAssets,
        hasMoreAssets: false,
        currentPage: 1,
        assetsPerPage: 20,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      final titleFinder = find.text('Assets da Exchange (2)');
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('deve manter espaçamento correto entre elementos', (
      tester,
    ) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoaded(
        ExchangeDetailsWithAssets(exchange: exchange, assets: mockAssets),
        allAssets: mockAssets,
        hasMoreAssets: false,
        currentPage: 1,
        assetsPerPage: 20,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      final titleFinder = find.text('Assets da Exchange (2)');
      expect(titleFinder, findsOneWidget);

      final titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('deve lidar com lista vazia de assets', (tester) async {
      final exchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: null,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );

      final state = ExchangeDetailsLoaded(
        ExchangeDetailsWithAssets(exchange: exchange, assets: []),
        allAssets: [],
        hasMoreAssets: false,
        currentPage: 1,
        assetsPerPage: 20,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(state));
      when(() => mockBloc.state).thenReturn(state);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Assets da Exchange (0)'), findsOneWidget);
      expect(find.byType(ExchangeAssetRow), findsNothing);
    });
  });
}
