import 'package:challenge_mb/src/features/exchanges/presentation/bloc/bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockExchangeDetailsBloc extends Mock implements ExchangeDetailsBloc {}

void main() {
  group('ExchangeLoadMoreButton Widget Tests', () {
    late MockExchangeDetailsBloc mockBloc;

    setUp(() {
      mockBloc = MockExchangeDetailsBloc();
    });

    testWidgets('deve renderizar botão de carregar mais corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.text('Carregar Mais Assets'), findsOneWidget);
    });

    testWidgets('deve renderizar botão quando hasMoreAssets é true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('deve não renderizar quando hasMoreAssets é false', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: false),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('deve renderizar com tema personalizado', (tester) async {
      final theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.text('Carregar Mais Assets'), findsOneWidget);
    });

    testWidgets('deve renderizar múltiplas instâncias corretamente', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
                ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: false),
                ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsNWidgets(3));

      expect(find.byType(FilledButton), findsNWidgets(2));
    });

    testWidgets('deve renderizar em diferentes tamanhos de tela', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(300, 600));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.text('Carregar Mais Assets'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('deve aplicar estilo do botão corretamente', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExchangeLoadMoreButton(bloc: mockBloc, hasMoreAssets: true),
          ),
        ),
      );

      expect(find.byType(ExchangeLoadMoreButton), findsOneWidget);

      expect(find.byType(FilledButton), findsOneWidget);

      expect(find.text('Carregar Mais Assets'), findsOneWidget);
    });
  });
}
