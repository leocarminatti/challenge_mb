import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/details/exchange_assets_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeAssetsTable', () {
    late List<dynamic> mockAssets;

    setUp(() {
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
        ExchangeAsset(
          walletAddress: '0x9876543210fedcba',
          balance: 25000.0,
          platform: Platform(cryptoId: 52, symbol: 'XRP', name: 'XRP'),
          currency: AssetCurrency(
            cryptoId: 52,
            priceUsd: 1.5,
            symbol: 'XRP',
            name: 'XRP',
          ),
        ),
      ];
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(body: ExchangeAssetsTable(assets: mockAssets)),
        debugShowCheckedModeBanner: false,
      );
    }

    testWidgets('deve renderizar cabeçalho da tabela', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Currency'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
    });

    testWidgets('deve renderizar todas as linhas de assets', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('deve renderizar nomes das moedas', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Bitcoin'), findsOneWidget);
      expect(find.text('Ethereum'), findsOneWidget);
      expect(find.text('XRP'), findsOneWidget);
    });

    testWidgets('deve renderizar preços formatados', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('\$50000'), findsOneWidget);
      expect(find.text('\$3000'), findsOneWidget);
      expect(find.text('\$1.50'), findsOneWidget);
    });

    testWidgets('deve renderizar ícone de ordenação no cabeçalho', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });

    testWidgets('deve aplicar estilos corretos ao cabeçalho', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final headerTexts = [
        find.text('#'),
        find.text('Currency'),
        find.text('Price'),
      ];

      for (final finder in headerTexts) {
        final textWidget = tester.widget<Text>(finder);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      }
    });

    testWidgets('deve aplicar estilos corretos às linhas', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final rowTexts = [
        find.text('Bitcoin'),
        find.text('Ethereum'),
        find.text('XRP'),
      ];

      for (final finder in rowTexts) {
        final textWidget = tester.widget<Text>(finder);
        expect(textWidget.style?.color, isNotNull);
      }
    });

    testWidgets('deve manter altura fixa da lista', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final sizedBoxes = find.byType(SizedBox);
      expect(sizedBoxes, findsNWidgets(7));

      expect(sizedBoxes, findsNWidgets(7));
    });

    testWidgets('deve aplicar bordas entre as linhas', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final containers = find.byType(Container);
      expect(containers, findsAtLeastNWidgets(2));
    });

    testWidgets('deve lidar com lista vazia', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeAssetsTable(assets: [])),
        ),
      );

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Currency'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);

      expect(find.text('1'), findsNothing);
    });

    testWidgets('deve lidar com asset com preço nulo', (tester) async {
      final assetsWithNullPrice = [
        ExchangeAsset(
          walletAddress: '0x1234567890abcdef',
          balance: 1000.5,
          platform: null,
          currency: AssetCurrency(
            cryptoId: 1,
            priceUsd: null,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeAssetsTable(assets: assetsWithNullPrice),
          ),
        ),
      );

      expect(find.byType(ExchangeAssetsTable), findsOneWidget);
      expect(find.text('Bitcoin'), findsOneWidget);
      expect(find.text('\$0.000000'), findsOneWidget);
    });

    testWidgets('deve lidar com asset com preço zero', (tester) async {
      final assetsWithZeroPrice = [
        ExchangeAsset(
          walletAddress: '0x1234567890abcdef',
          balance: 1000.5,
          platform: null,
          currency: AssetCurrency(
            cryptoId: 1,
            priceUsd: 0.0,
            symbol: 'BTC',
            name: 'Bitcoin',
          ),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeAssetsTable(assets: assetsWithZeroPrice),
          ),
        ),
      );

      expect(find.byType(ExchangeAssetsTable), findsOneWidget);
      expect(find.text('Bitcoin'), findsOneWidget);
      expect(find.text('\$0.000000'), findsOneWidget);
    });

    testWidgets('deve aplicar overflow ellipsis para nomes longos', (
      tester,
    ) async {
      final assetsWithLongNames = [
        ExchangeAsset(
          walletAddress: '0x1234567890abcdef',
          balance: 1000.5,
          platform: null,
          currency: AssetCurrency(
            cryptoId: 1,
            priceUsd: 50000.0,
            symbol: 'BTC',
            name: 'Very Long Currency Name That Exceeds Normal Length Limits',
          ),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeAssetsTable(assets: assetsWithLongNames),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(
        find.text('Very Long Currency Name That Exceeds Normal Length Limits'),
      );
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('deve usar tema correto para cores', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final theme = Theme.of(tester.element(find.byType(MaterialApp)));
      final headerText = tester.widget<Text>(find.text('#'));

      expect(headerText.style?.color, theme.colorScheme.onSurface);
    });

    testWidgets('deve manter padding correto nas células', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final containers = find.byType(Container);
      final dataContainer = containers.last;
      final containerWidget = tester.widget<Container>(dataContainer);

      expect(
        containerWidget.padding,
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      );
    });

    testWidgets('deve aplicar borderRadius ao cabeçalho', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final headerContainer = find.byType(Container).first;
      final containerWidget = tester.widget<Container>(headerContainer);

      final decoration = containerWidget.decoration as BoxDecoration?;
      expect(decoration?.borderRadius, BorderRadius.circular(8));
    });

    testWidgets('deve usar AlwaysScrollableScrollPhysics', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final listView = tester.widget<ListView>(find.byType(ListView));

      expect(listView.physics, const AlwaysScrollableScrollPhysics());
    });
  });
}
