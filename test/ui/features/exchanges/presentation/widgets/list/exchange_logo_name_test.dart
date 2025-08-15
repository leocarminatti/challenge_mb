import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeLogoName Widget Tests', () {
    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 1000000000.0,
      );
    }

    testWidgets('deve renderizar com logo quando fornecido', (tester) async {
      final exchange = createMockExchange(logo: 'https://example.com/logo.png');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLogoName(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeLogoName), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('deve renderizar com ícone padrão quando logo não fornecido', (
      tester,
    ) async {
      final exchange = createMockExchange(logo: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLogoName(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.byType(ExchangeLogoName), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);

      expect(find.byIcon(Icons.business), findsOneWidget);
    });

    testWidgets('deve renderizar nome longo corretamente', (tester) async {
      final exchange = createMockExchange(
        name: 'Very Long Exchange Name That Exceeds Normal Length Limits',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLogoName(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(
        find.text('Very Long Exchange Name That Exceeds Normal Length Limits'),
        findsOneWidget,
      );
    });

    testWidgets('deve renderizar nome curto corretamente', (tester) async {
      final exchange = createMockExchange(name: 'OKX');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLogoName(exchange: exchange, theme: ThemeData()),
          ),
        ),
      );

      expect(find.text('OKX'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
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
                  .map(
                    (exchange) => ExchangeLogoName(
                      exchange: exchange,
                      theme: ThemeData(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeLogoName), findsNWidgets(3));

      expect(find.text('Binance'), findsOneWidget);
      expect(find.text('Coinbase'), findsOneWidget);
      expect(find.text('Kraken'), findsOneWidget);
    });

    testWidgets('deve aplicar tema corretamente', (tester) async {
      final exchange = createMockExchange();
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: TextTheme(
          titleMedium: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ExchangeLogoName(exchange: exchange, theme: theme),
          ),
        ),
      );

      expect(find.byType(ExchangeLogoName), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });
  });
}
