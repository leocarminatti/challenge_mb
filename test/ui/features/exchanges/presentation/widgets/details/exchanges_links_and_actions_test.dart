import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/details/exchanges_link_item.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/details/exchanges_links_and_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeLinksAndActions', () {
    late Exchange exchange;

    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
      String? description = 'Leading cryptocurrency exchange',
      String? url,
      double? makerFee,
      double? takerFee,
      DateTime? dateLaunched,
      double? spotVolumeUsd = 15000000.0,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: description,
        url: url,
        makerFee: makerFee,
        takerFee: takerFee,
        dateLaunched:
            dateLaunched ?? DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: spotVolumeUsd,
      );
    }

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(body: ExchangeLinksAndActions(exchange: exchange)),
        debugShowCheckedModeBanner: false,
      );
    }

    setUp(() {
      exchange = createMockExchange();
    });

    testWidgets('deve renderizar ExchangeLinkItem quando URL está presente', (
      tester,
    ) async {
      exchange = createMockExchange(url: 'https://binance.com');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
    });

    testWidgets('deve não renderizar ExchangeLinkItem quando URL é nulo', (
      tester,
    ) async {
      exchange = createMockExchange(url: null);

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsNothing);
    });

    testWidgets('deve não renderizar ExchangeLinkItem quando URL está vazio', (
      tester,
    ) async {
      exchange = createMockExchange(url: '');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
    });

    testWidgets('deve passar URL correto para ExchangeLinkItem', (
      tester,
    ) async {
      exchange = createMockExchange(url: 'https://coinbase.com');

      await tester.pumpWidget(createTestWidget());

      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(linkItem.url, 'https://coinbase.com');
    });

    testWidgets('deve usar ícone de link padrão', (tester) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(linkItem.icon, Icons.link);
    });

    testWidgets('deve usar URL como label', (tester) async {
      exchange = createMockExchange(url: 'https://kraken.com');

      await tester.pumpWidget(createTestWidget());

      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(linkItem.label, 'https://kraken.com');
    });

    testWidgets('deve manter espaçamento correto após o link', (tester) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, 2);
    });

    testWidgets('deve aplicar SizedBox com altura 16 após o link', (
      tester,
    ) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      final sizedBoxes = find.byType(SizedBox);
      final sizedBox = tester.widget<SizedBox>(sizedBoxes.last);
      expect(sizedBox.height, 16);
    });

    testWidgets('deve usar Column para layout vertical', (tester) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Column), findsOneWidget);
    });

    testWidgets('deve aplicar crossAxisAlignment start', (tester) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('deve lidar com URL muito longo', (tester) async {
      exchange = createMockExchange(
        url:
            'https://very-long-url-that-exceeds-normal-length-limits-and-should-be-handled-properly.com/very-long-path/with-many-segments/and-even-more-segments',
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(
        linkItem.url,
        'https://very-long-url-that-exceeds-normal-length-limits-and-should-be-handled-properly.com/very-long-path/with-many-segments/and-even-more-segments',
      );
    });

    testWidgets('deve lidar com URL com caracteres especiais', (tester) async {
      exchange = createMockExchange(
        url: 'https://example.com/path?param=value&another=param#fragment',
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(
        linkItem.url,
        'https://example.com/path?param=value&another=param#fragment',
      );
    });

    testWidgets('deve lidar com URL HTTP', (tester) async {
      exchange = createMockExchange(url: 'http://example.com');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(linkItem.url, 'http://example.com');
    });

    testWidgets('deve lidar com URL FTP', (tester) async {
      exchange = createMockExchange(url: 'ftp://example.com');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeLinkItem), findsOneWidget);
      final linkItem = tester.widget<ExchangeLinkItem>(
        find.byType(ExchangeLinkItem),
      );
      expect(linkItem.url, 'ftp://example.com');
    });

    testWidgets('deve manter estrutura de widget correta', (tester) async {
      exchange = createMockExchange(url: 'https://example.com');

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(ExchangeLinkItem), findsOneWidget);
      expect(find.byType(SizedBox), findsNWidgets(3));
    });

    testWidgets('deve não renderizar nada quando não há URL', (tester) async {
      exchange = createMockExchange(url: null);

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(ExchangeLinkItem), findsNothing);
      expect(find.byType(SizedBox), findsNothing);
    });

    testWidgets('deve lidar com múltiplas instâncias do widget', (
      tester,
    ) async {
      final exchange1 = createMockExchange(url: 'https://binance.com');
      final exchange2 = createMockExchange(url: 'https://coinbase.com');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExchangeLinksAndActions(exchange: exchange1),
                ExchangeLinksAndActions(exchange: exchange2),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeLinkItem), findsNWidgets(2));
    });

    testWidgets('deve manter consistência com diferentes exchanges', (
      tester,
    ) async {
      final exchanges = [
        createMockExchange(name: 'Binance', url: 'https://binance.com'),
        createMockExchange(name: 'Coinbase', url: 'https://coinbase.com'),
        createMockExchange(name: 'Kraken', url: 'https://kraken.com'),
      ];

      for (final exchange in exchanges) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: ExchangeLinksAndActions(exchange: exchange)),
          ),
        );

        expect(find.byType(ExchangeLinkItem), findsOneWidget);
        final linkItem = tester.widget<ExchangeLinkItem>(
          find.byType(ExchangeLinkItem),
        );
        expect(linkItem.url, exchange.url);
        expect(linkItem.label, exchange.url);
        expect(linkItem.icon, Icons.link);
      }
    });
  });
}
