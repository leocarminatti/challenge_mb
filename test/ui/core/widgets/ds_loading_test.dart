import 'package:challenge_mb/core/widgets/ds_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DsLoading Widget Tests', () {
    testWidgets('deve renderizar o widget de loading corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DsLoading())),
      );

      expect(find.byType(DsLoading), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar com texto personalizado', (tester) async {
      const customText = 'Carregando dados...';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DsLoading(message: customText)),
        ),
      );

      expect(find.text(customText), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar sem texto quando não fornecido', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DsLoading())),
      );

      expect(find.text('Carregando...'), findsNothing);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          ),
          home: const Scaffold(body: DsLoading()),
        ),
      );

      expect(find.byType(DsLoading), findsOneWidget);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DsLoading(message: 'Carregando 1'),
                DsLoading(message: 'Carregando 2'),
                DsLoading(message: 'Carregando 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(DsLoading), findsNWidgets(3));
      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
      expect(find.text('Carregando 1'), findsOneWidget);
      expect(find.text('Carregando 2'), findsOneWidget);
      expect(find.text('Carregando 3'), findsOneWidget);
    });
  });
}
