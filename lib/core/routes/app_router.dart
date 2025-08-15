import 'package:go_router/go_router.dart';

import '../../src/features/exchanges/exchanges.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'exchanges',
      builder: (context, state) => const ExchangesPage(),
    ),
    GoRoute(
      path: '/exchange',
      name: 'exchange_details',
      builder: (context, state) {
        final exchange = state.extra as Exchange;
        return ExchangeDetailsPage(exchange: exchange);
      },
    ),
  ],
);
