import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/details/exchanges_financial_metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeFinancialMetrics', () {
    late Exchange exchange;

    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
      String? description = 'Leading cryptocurrency exchange',
      double? spotVolumeUsd = 15000000.0,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: description,
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: spotVolumeUsd,
      );
    }

    setUp(() {
      exchange = createMockExchange(spotVolumeUsd: 15000000.0);
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(body: ExchangeFinancialMetrics(exchange: exchange)),
        debugShowCheckedModeBanner: false,
      );
    }

    testWidgets('deve renderizar o título do volume de trading', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Spot Trading Volume (24h)'), findsOneWidget);
    });

    testWidgets('deve renderizar o volume formatado em USD', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('\$15.00M'), findsOneWidget);
    });

    testWidgets('deve renderizar o equivalente em BTC', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('300 BTC'), findsOneWidget);
    });

    testWidgets('deve renderizar o título de total de assets', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Total assets'), findsOneWidget);
    });

    testWidgets('deve renderizar o total de assets calculado', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('\$90.00M'), findsOneWidget);
    });

    testWidgets('deve aplicar estilos corretos ao título do volume', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final titleFinder = find.text('Spot Trading Volume (24h)');
      final titleWidget = tester.widget<Text>(titleFinder);

      expect(titleWidget.style?.color?.withValues(alpha: 0.7), isNotNull);
    });

    testWidgets('deve aplicar estilos corretos ao valor do volume', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final valueFinder = find.text('\$15.00M');
      final valueWidget = tester.widget<Text>(valueFinder);

      expect(valueWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('deve aplicar estilos corretos ao equivalente em BTC', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final btcFinder = find.text('300 BTC');
      final btcWidget = tester.widget<Text>(btcFinder);

      expect(btcWidget.style?.color?.withValues(alpha: 0.7), isNotNull);
    });

    testWidgets('deve aplicar estilos corretos ao título de assets', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final assetsTitleFinder = find.text('Total assets');
      final assetsTitleWidget = tester.widget<Text>(assetsTitleFinder);

      expect(assetsTitleWidget.style?.color?.withValues(alpha: 0.7), isNotNull);
    });

    testWidgets('deve aplicar estilos corretos ao valor total de assets', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final totalAssetsFinder = find.text('\$90.00M');
      final totalAssetsWidget = tester.widget<Text>(totalAssetsFinder);

      expect(totalAssetsWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('deve lidar com volume zero', (tester) async {
      exchange = createMockExchange(spotVolumeUsd: 0.0);
      await tester.pumpWidget(createTestWidget());

      expect(find.text('\$0.00'), findsNWidgets(2));
      expect(find.text('0 BTC'), findsOneWidget);
    });

    testWidgets('deve lidar com volume nulo', (tester) async {
      exchange = createMockExchange(spotVolumeUsd: null);
      await tester.pumpWidget(createTestWidget());

      expect(find.text('\$0.00'), findsNWidgets(2));
      expect(find.text('0 BTC'), findsOneWidget);
    });

    testWidgets('deve manter espaçamento correto entre elementos', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final column = tester.widget<Column>(find.byType(Column));

      expect(column.children.length, 9);
    });

    testWidgets('deve usar tema correto para cores', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final theme = Theme.of(tester.element(find.byType(MaterialApp)));
      final volumeText = tester.widget<Text>(find.text('\$15.00M'));

      expect(volumeText.style?.color, theme.colorScheme.onSurface);
    });
  });
}
