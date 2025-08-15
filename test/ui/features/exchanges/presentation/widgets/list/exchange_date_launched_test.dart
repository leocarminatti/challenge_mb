import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeDateLaunched Widget Tests', () {
    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      DateTime? dateLaunched,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: 'https://example.com/logo.png',
        description: 'Leading cryptocurrency exchange',
        dateLaunched:
            dateLaunched ?? DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );
    }

    testWidgets('deve renderizar data de lançamento corretamente', (
      tester,
    ) async {
      final exchange = createMockExchange();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeDateLaunched(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeDateLaunched), findsOneWidget);

      expect(find.text('2017'), findsOneWidget);
    });

    testWidgets('deve renderizar data antiga corretamente', (tester) async {
      final exchange = createMockExchange(
        dateLaunched: DateTime.parse('2010-01-01T00:00:00.000Z'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeDateLaunched(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeDateLaunched), findsOneWidget);

      expect(find.text('2010'), findsOneWidget);
    });

    testWidgets('deve renderizar data recente corretamente', (tester) async {
      final exchange = createMockExchange(
        dateLaunched: DateTime.parse('2023-12-31T23:59:59.000Z'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeDateLaunched(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeDateLaunched), findsOneWidget);

      expect(find.text('2023'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplos itens corretamente', (tester) async {
      final exchanges = [
        createMockExchange(
          id: '1',
          name: 'Binance',
          dateLaunched: DateTime.parse('2017-01-01'),
        ),
        createMockExchange(
          id: '2',
          name: 'Coinbase',
          dateLaunched: DateTime.parse('2012-01-01'),
        ),
        createMockExchange(
          id: '3',
          name: 'Kraken',
          dateLaunched: DateTime.parse('2011-01-01'),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: exchanges
                  .map(
                    (exchange) => ExchangeDateLaunched(
                      exchange: exchange,
                      theme: ThemeData(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeDateLaunched), findsNWidgets(3));

      expect(find.text('2017'), findsOneWidget);
      expect(find.text('2012'), findsOneWidget);
      expect(find.text('2011'), findsOneWidget);
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
            body: ExchangeDateLaunched(exchange: exchange, theme: theme),
          ),
        ),
      );

      expect(find.byType(ExchangeDateLaunched), findsOneWidget);

      expect(find.text('2017'), findsOneWidget);
    });
  });
}
