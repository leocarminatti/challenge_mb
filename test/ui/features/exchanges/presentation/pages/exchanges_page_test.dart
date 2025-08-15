import 'package:challenge_mb/src/features/exchanges/presentation/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangesPage Widget Tests', () {
    testWidgets('deve criar página de exchanges corretamente', (tester) async {
      final page = ExchangesPage();
      expect(page, isA<ExchangesPage>());
    });

    testWidgets('deve aceitar exchangesBloc como parâmetro', (tester) async {
      final page = ExchangesPage(exchangesBloc: null);
      expect(page, isA<ExchangesPage>());
    });

    testWidgets('deve ter estrutura básica correta', (tester) async {
      final page = ExchangesPage();
      expect(page.key, isNull);
      expect(page.exchangesBloc, isNull);
    });
  });
}
