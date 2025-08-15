import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'mocks/test_mocks.dart';

class TestSetup {
  static void setupTestEnvironment() {
    final getIt = GetIt.instance;

    if (getIt.isRegistered<ExchangesBloc>()) {
      getIt.unregister<ExchangesBloc>();
    }
    if (getIt.isRegistered<ExchangeDetailsBloc>()) {
      getIt.unregister<ExchangeDetailsBloc>();
    }

    getIt.registerLazySingleton<ExchangesBloc>(() => MockExchangesBloc());

    getIt.registerLazySingleton<ExchangeDetailsBloc>(
      () => MockExchangeDetailsBloc(),
    );
  }

  static void tearDownTestEnvironment() {
    final getIt = GetIt.instance;

    if (getIt.isRegistered<ExchangesBloc>()) {
      getIt.unregister<ExchangesBloc>();
    }
    if (getIt.isRegistered<ExchangeDetailsBloc>()) {
      getIt.unregister<ExchangeDetailsBloc>();
    }
  }
}

mixin BlocTestMixin on WidgetTester {
  void setupBlocMocks() {
    TestSetup.setupTestEnvironment();
  }

  void tearDownBlocMocks() {
    TestSetup.tearDownTestEnvironment();
  }
}
