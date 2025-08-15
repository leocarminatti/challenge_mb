import 'package:challenge_mb/core/widgets/ds_ranking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DSRanking Widget Tests', () {
    testWidgets('deve renderizar ranking corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: '#1', color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      expect(find.text('#1'), findsOneWidget);
    });

    testWidgets('deve renderizar com cor personalizada', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: '#2', color: customColor),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      expect(find.text('#2'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, customColor);
    });

    testWidgets('deve renderizar texto longo corretamente', (tester) async {
      const longText = '#999';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: longText, color: Colors.green),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      expect(find.text('#999'), findsOneWidget);
    });

    testWidgets('deve renderizar texto curto corretamente', (tester) async {
      const shortText = '#1';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: shortText, color: Colors.orange),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      expect(find.text('#1'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DSRanking(text: '#1', color: Colors.blue),
                DSRanking(text: '#2', color: Colors.green),
                DSRanking(text: '#3', color: Colors.orange),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsNWidgets(3));

      expect(find.text('#1'), findsOneWidget);
      expect(find.text('#2'), findsOneWidget);
      expect(find.text('#3'), findsOneWidget);
    });

    testWidgets('deve aplicar estilo de texto corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: '#1', color: Colors.purple),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontSize, 16.0);
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(200, 400));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DSRanking(text: '#1', color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(DSRanking), findsOneWidget);

      expect(find.text('#1'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
