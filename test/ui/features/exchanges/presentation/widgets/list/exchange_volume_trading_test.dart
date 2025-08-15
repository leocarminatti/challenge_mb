import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeVolumeTrading Widget Tests', () {
    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      double? spotVolumeUsd = 15000000.0,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: 'https://example.com/logo.png',
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: spotVolumeUsd,
      );
    }

    testWidgets('deve renderizar volume padrão corretamente', (tester) async {
      final exchange = createMockExchange();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('\$15.00M'), findsOneWidget);

      expect(find.text('24h'), findsOneWidget);
    });

    testWidgets('deve renderizar volume alto corretamente', (tester) async {
      final exchange = createMockExchange(spotVolumeUsd: 5000000000.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('\$5.00B'), findsOneWidget);

      expect(find.text('24h'), findsOneWidget);
    });

    testWidgets('deve renderizar volume baixo corretamente', (tester) async {
      final exchange = createMockExchange(spotVolumeUsd: 500000.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('\$500.00K'), findsOneWidget);

      expect(find.text('24h'), findsOneWidget);
    });

    testWidgets('deve renderizar volume zero corretamente', (tester) async {
      final exchange = createMockExchange(spotVolumeUsd: 0.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('\$0.00'), findsOneWidget);

      expect(find.text('24h'), findsOneWidget);
    });

    testWidgets('deve renderizar volume nulo corretamente', (tester) async {
      final exchange = createMockExchange(spotVolumeUsd: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('N/A'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplos itens corretamente', (tester) async {
      final exchanges = [
        createMockExchange(id: '1', name: 'Binance', spotVolumeUsd: 1000000.0),
        createMockExchange(id: '2', name: 'Coinbase', spotVolumeUsd: 500000.0),
        createMockExchange(id: '3', name: 'Kraken', spotVolumeUsd: 250000.0),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: exchanges
                  .map(
                    (exchange) => ExchangeVolumeTrading(
                      exchange: exchange,
                      theme: ThemeData(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsNWidgets(3));

      expect(find.text('\$1.00M'), findsOneWidget);
      expect(find.text('\$500.00K'), findsOneWidget);
      expect(find.text('\$250.00K'), findsOneWidget);
    });

    testWidgets('deve aplicar tema corretamente', (tester) async {
      final exchange = createMockExchange();
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ExchangeVolumeTrading(exchange: exchange, theme: theme),
          ),
        ),
      );

      expect(find.byType(ExchangeVolumeTrading), findsOneWidget);

      expect(find.text('\$15.00M'), findsOneWidget);
    });
  });
}
