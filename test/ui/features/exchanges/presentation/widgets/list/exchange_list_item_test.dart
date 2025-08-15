import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeListItem Widget Tests', () {
    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
      double? spotVolumeUsd = 15000000.0,
      DateTime? dateLaunched,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: 'Leading cryptocurrency exchange',
        dateLaunched:
            dateLaunched ?? DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: spotVolumeUsd,
      );
    }

    testWidgets('deve renderizar item de exchange corretamente', (
      tester,
    ) async {
      final exchange = createMockExchange();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeListItem(exchange: exchange, rank: 1)),
        ),
      );

      expect(find.byType(ExchangeListItem), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);

      expect(find.text('#1'), findsOneWidget);
    });

    testWidgets('deve renderizar com volume alto corretamente', (tester) async {
      final exchange = createMockExchange(spotVolumeUsd: 5000000000.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeListItem(exchange: exchange, rank: 1)),
        ),
      );

      expect(find.byType(ExchangeListItem), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar sem logo corretamente', (tester) async {
      final exchange = createMockExchange(logo: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeListItem(exchange: exchange, rank: 1)),
        ),
      );

      expect(find.byType(ExchangeListItem), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar nome longo corretamente', (tester) async {
      final exchange = createMockExchange(
        name: 'Very Long Exchange Name That Exceeds Normal Length Limits',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeListItem(exchange: exchange, rank: 1)),
        ),
      );

      expect(find.byType(ExchangeListItem), findsOneWidget);

      expect(
        find.text('Very Long Exchange Name That Exceeds Normal Length Limits'),
        findsOneWidget,
      );
    });

    testWidgets('deve renderizar múltiplos itens corretamente', (tester) async {
      final exchanges = [
        createMockExchange(id: '1', name: 'Binance'),
        createMockExchange(id: '2', name: 'Coinbase'),
        createMockExchange(id: '3', name: 'Kraken'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: exchanges
                  .asMap()
                  .entries
                  .map(
                    (entry) => ExchangeListItem(
                      exchange: entry.value,
                      rank: entry.key + 1,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeListItem), findsNWidgets(3));

      expect(find.text('Binance'), findsOneWidget);
      expect(find.text('Coinbase'), findsOneWidget);
      expect(find.text('Kraken'), findsOneWidget);

      expect(find.text('#1'), findsOneWidget);
      expect(find.text('#2'), findsOneWidget);
      expect(find.text('#3'), findsOneWidget);
    });

    testWidgets('deve aplicar tema corretamente', (tester) async {
      final exchange = createMockExchange();
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(body: ExchangeListItem(exchange: exchange, rank: 1)),
        ),
      );

      expect(find.byType(ExchangeListItem), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });
  });
}
