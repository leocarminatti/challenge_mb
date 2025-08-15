import 'package:challenge_mb/core/widgets/ds_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DSIcon Widget Tests', () {
    testWidgets('deve renderizar ícone corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DSIcon(url: 'https://example.com/icon.png')),
        ),
      );

      expect(find.byType(DSIcon), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('deve renderizar com URL personalizada', (tester) async {
      const customUrl = 'https://example.com/custom-icon.png';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DSIcon(url: customUrl)),
        ),
      );

      expect(find.byType(DSIcon), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: DSIcon(url: 'https://example.com/icon.png'),
          ),
        ),
      );

      expect(find.byType(DSIcon), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DSIcon(url: 'https://example.com/icon1.png'),
                DSIcon(url: 'https://example.com/icon2.png'),
                DSIcon(url: 'https://example.com/icon3.png'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DSIcon), findsNWidgets(3));

      expect(find.byType(Image), findsNWidgets(3));
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(200, 400));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DSIcon(url: 'https://example.com/icon.png')),
        ),
      );

      expect(find.byType(DSIcon), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('deve aplicar propriedades da imagem corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DSIcon(url: 'https://example.com/icon.png')),
        ),
      );

      expect(find.byType(DSIcon), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(ClipRRect), findsOneWidget);
    });
  });
}
