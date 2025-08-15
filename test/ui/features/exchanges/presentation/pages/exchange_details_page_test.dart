import 'package:challenge_mb/src/features/exchanges/domain/domain.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeDetailsPage Widget Tests', () {
    late Exchange mockExchange;

    setUp(() {
      mockExchange = Exchange(
        id: '1',
        name: 'Binance',
        logo: 'https://example.com/binance.png',
        description: 'Leading cryptocurrency exchange',
        dateLaunched: DateTime.parse('2017-07-14T20:00:00.000Z'),
        spotVolumeUsd: 15000000.0,
      );
    });

    testWidgets('deve criar página de detalhes corretamente', (tester) async {
      final page = ExchangeDetailsPage(exchange: mockExchange);
      expect(page, isA<ExchangeDetailsPage>());
    });

    testWidgets('deve aceitar exchange como parâmetro obrigatório', (
      tester,
    ) async {
      final page = ExchangeDetailsPage(exchange: mockExchange);
      expect(page.exchange, equals(mockExchange));
    });

    testWidgets('deve ter estrutura básica correta', (tester) async {
      final page = ExchangeDetailsPage(exchange: mockExchange);
      expect(page.key, isNull);
      expect(page.exchange, equals(mockExchange));
    });
  });
}
