import 'package:challenge_mb/core/widgets/ds_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DsLogo Widget Tests', () {
    testWidgets('deve renderizar logo corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DsLogo(width: 40.0, height: 40.0)),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);
    });

    testWidgets('deve renderizar com tamanho personalizado', (tester) async {
      const customWidth = 80.0;
      const customHeight = 60.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DsLogo(width: customWidth, height: customHeight),
          ),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);
    });

    testWidgets('deve renderizar com cor personalizada', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DsLogo(width: 40.0, height: 40.0, color: customColor),
          ),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(body: DsLogo(width: 40.0, height: 40.0)),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DsLogo(width: 40.0, height: 40.0),
                DsLogo(width: 60.0, height: 60.0),
                DsLogo(width: 80.0, height: 80.0),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DsLogo), findsNWidgets(3));
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(200, 400));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DsLogo(width: 40.0, height: 40.0)),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('deve aplicar propriedades do SVG corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DsLogo(width: 40.0, height: 40.0, fit: BoxFit.cover),
          ),
        ),
      );

      expect(find.byType(DsLogo), findsOneWidget);
    });
  });
}
