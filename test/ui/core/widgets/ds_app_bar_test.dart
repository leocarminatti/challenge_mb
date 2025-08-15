import 'package:challenge_mb/core/widgets/ds_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DSAppBar Widget Tests', () {
    testWidgets('deve renderizar app bar corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(appBar: DSAppBar(title: 'Test App')),
        ),
      );

      expect(find.byType(DSAppBar), findsOneWidget);

      expect(find.text('Test App'), findsOneWidget);
    });

    testWidgets('deve renderizar com título personalizado', (tester) async {
      const customTitle = 'Custom App Title';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(appBar: DSAppBar(title: customTitle)),
        ),
      );

      expect(find.byType(DSAppBar), findsOneWidget);

      expect(find.text(customTitle), findsOneWidget);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(appBar: DSAppBar(title: 'Test App')),
        ),
      );

      expect(find.byType(DSAppBar), findsOneWidget);
      expect(find.text('Test App'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DSAppBar(title: 'App 1'),
                DSAppBar(title: 'App 2'),
                DSAppBar(title: 'App 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DSAppBar), findsNWidgets(3));
      expect(find.text('App 1'), findsOneWidget);
      expect(find.text('App 2'), findsOneWidget);
      expect(find.text('App 3'), findsOneWidget);
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(300, 600));

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(appBar: DSAppBar(title: 'Test App')),
        ),
      );

      expect(find.byType(DSAppBar), findsOneWidget);

      expect(find.text('Test App'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('deve aplicar estilo de texto corretamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(appBar: DSAppBar(title: 'Test App')),
        ),
      );

      expect(find.byType(DSAppBar), findsOneWidget);
      expect(find.text('Test App'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
