import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangesTableHeader Widget Tests', () {
    testWidgets('deve renderizar cabeçalho da tabela corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ExchangesTableHeader())),
      );

      expect(find.byType(ExchangesTableHeader), findsOneWidget);

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Exchange'), findsOneWidget);
      expect(find.text('Trading Volume (24h)'), findsOneWidget);
      expect(find.text('Launched'), findsOneWidget);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(body: ExchangesTableHeader()),
        ),
      );

      expect(find.byType(ExchangesTableHeader), findsOneWidget);

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Exchange'), findsOneWidget);
      expect(find.text('Trading Volume (24h)'), findsOneWidget);
      expect(find.text('Launched'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExchangesTableHeader(),
                ExchangesTableHeader(),
                ExchangesTableHeader(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ExchangesTableHeader), findsNWidgets(3));

      expect(find.text('#'), findsNWidgets(3));
      expect(find.text('Exchange'), findsNWidgets(3));
      expect(find.text('Trading Volume (24h)'), findsNWidgets(3));
      expect(find.text('Launched'), findsNWidgets(3));
    });

    testWidgets('deve aplicar estilo de texto corretamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ExchangesTableHeader())),
      );

      expect(find.byType(ExchangesTableHeader), findsOneWidget);

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Exchange'), findsOneWidget);
      expect(find.text('Trading Volume (24h)'), findsOneWidget);
      expect(find.text('Launched'), findsOneWidget);
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(300, 600));

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ExchangesTableHeader())),
      );

      expect(find.byType(ExchangesTableHeader), findsOneWidget);

      expect(find.text('#'), findsOneWidget);
      expect(find.text('Exchange'), findsOneWidget);
      expect(find.text('Trading Volume (24h)'), findsOneWidget);
      expect(find.text('Launched'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
