import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/widgets/details/exchanges_about_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeAboutSection', () {
    late Exchange exchange;

    Exchange createMockExchange({
      String id = '1',
      String name = 'Binance',
      String? logo,
      String? description = 'Leading cryptocurrency exchange',
      String? url,
      double? makerFee,
      double? takerFee,
      DateTime? dateLaunched,
      double? spotVolumeUsd = 15000000.0,
    }) {
      return Exchange(
        id: id,
        name: name,
        logo: logo,
        description: description,
        url: url,
        makerFee: makerFee,
        takerFee: takerFee,
        dateLaunched:
            dateLaunched ?? DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: spotVolumeUsd,
      );
    }

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(body: ExchangeAboutSection(exchange: exchange)),
        debugShowCheckedModeBanner: false,
      );
    }

    setUp(() {
      exchange = createMockExchange();
    });

    testWidgets('deve renderizar o título da seção', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('About Binance'), findsOneWidget);
    });

    testWidgets('deve renderizar a pergunta sobre a exchange', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('What Is Binance?'), findsOneWidget);
    });

    testWidgets('deve renderizar a descrição completa quando curta', (
      tester,
    ) async {
      exchange = createMockExchange(description: 'Short description.');

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Short description.'), findsNWidgets(2));
    });

    testWidgets('deve truncar descrição longa por caracteres', (tester) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('A' * 150 + '...'), findsOneWidget);
    });

    testWidgets('deve lidar com descrição com quebras de linha', (
      tester,
    ) async {
      exchange = createMockExchange(
        description: 'Line 1\nLine 2\nLine 3\nLine 4\nLine 5',
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ExchangeAboutSection), findsOneWidget);
    });

    testWidgets('deve mostrar botão expandir quando descrição é longa', (
      tester,
    ) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('Mostrar Mais'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);
    });

    testWidgets('deve expandir descrição quando botão é pressionado', (
      tester,
    ) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.text('Mostrar Mais'));
      await tester.pump();

      expect(find.text('A' * 200), findsNWidgets(2));
      expect(find.text('A' * 150 + '...'), findsNothing);
    });

    testWidgets(
      'deve contrair descrição quando botão é pressionado novamente',
      (tester) async {
        exchange = createMockExchange(description: 'A' * 200);

        await tester.pumpWidget(createTestWidget());

        await tester.tap(find.text('Mostrar Mais'));
        await tester.pump();

        await tester.tap(find.text('Mostrar Menos'));
        await tester.pump();

        expect(find.text('A' * 150 + '...'), findsAtLeastNWidgets(1));
      },
    );

    testWidgets('deve mudar ícone quando expandido/contraído', (tester) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      expect(find.byIcon(Icons.expand_more), findsOneWidget);
      expect(find.byIcon(Icons.expand_less), findsNothing);

      await tester.tap(find.text('Mostrar Mais'));
      await tester.pump();

      expect(find.byIcon(Icons.expand_less), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsNothing);
    });

    testWidgets('deve lidar com descrição nula', (tester) async {
      exchange = createMockExchange(description: null);

      await tester.pumpWidget(createTestWidget());

      expect(find.text('No description available.'), findsOneWidget);
    });

    testWidgets('deve aplicar tema correto ao título', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final titleFinder = find.text('About Binance');
      final titleWidget = tester.widget<Text>(titleFinder);

      expect(titleWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('deve aplicar tema correto à pergunta', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final questionFinder = find.text('What Is Binance?');
      final questionWidget = tester.widget<Text>(questionFinder);

      expect(questionWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('deve aplicar tema correto à descrição', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final descriptionFinder = find
          .text('Leading cryptocurrency exchange')
          .first;
      final descriptionWidget = tester.widget<Text>(descriptionFinder);

      expect(descriptionWidget.style?.color?.withValues(alpha: 0.9), isNotNull);
      expect(descriptionWidget.style?.height, 1.5);
    });

    testWidgets('deve aplicar tema correto ao botão', (tester) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      final buttonFinder = find.text('Mostrar Mais');
      final buttonWidget = tester.widget<Text>(buttonFinder);

      expect(buttonWidget.style?.color, isNotNull);
      expect(buttonWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('deve manter espaçamento correto entre elementos', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      final column = tester.widget<Column>(find.byType(Column));

      expect(column.children.length >= 5, isTrue);
    });

    testWidgets('deve usar AnimatedCrossFade para transição', (tester) async {
      exchange = createMockExchange(description: 'A' * 200);

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AnimatedCrossFade), findsOneWidget);
    });

    testWidgets('deve lidar com nome de exchange longo', (tester) async {
      exchange = createMockExchange(
        name: 'Very Long Exchange Name That Exceeds Normal Length',
      );

      await tester.pumpWidget(createTestWidget());

      expect(
        find.text('About Very Long Exchange Name That Exceeds Normal Length'),
        findsOneWidget,
      );
      expect(
        find.text(
          'What Is Very Long Exchange Name That Exceeds Normal Length?',
        ),
        findsOneWidget,
      );
    });
  });
}
