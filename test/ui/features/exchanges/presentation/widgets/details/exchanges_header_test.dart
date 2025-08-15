import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeHeader Widget Tests', () {
    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
      String? description = 'Leading cryptocurrency exchange',
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: description,
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );
    }

    testWidgets('deve renderizar header da exchange corretamente', (
      tester,
    ) async {
      final exchange = createMockExchange();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar com logo quando fornecido', (tester) async {
      final exchange = createMockExchange(logo: 'https://example.com/logo.png');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar sem logo quando não fornecido', (
      tester,
    ) async {
      final exchange = createMockExchange(logo: null);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar nome longo corretamente', (tester) async {
      final exchange = createMockExchange(
        name: 'Very Long Exchange Name That Exceeds Normal Length Limits',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(
        find.text('Very Long Exchange Name That Exceeds Normal Length Limits'),
        findsOneWidget,
      );
    });

    testWidgets('deve aplicar tema corretamente', (tester) async {
      final exchange = createMockExchange();
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      final exchange = createMockExchange();

      await tester.binding.setSurfaceSize(const Size(300, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExchangeHeader(exchange: exchange)),
        ),
      );

      expect(find.byType(ExchangeHeader), findsOneWidget);

      expect(find.text('Binance'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
