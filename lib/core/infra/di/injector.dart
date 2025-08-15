import 'package:get_it/get_it.dart';

import '../../../src/features/exchanges/exchange_di.dart';
import '../../config/env_config.dart';
import '../http/http.dart';

final getIt = GetIt.instance;

class Injector {
  static void init() {
    getIt.registerLazySingleton<HttpClient>(
      () => HttpClientImpl(
        baseUrl: EnvConfig.baseUrl,
        interceptor: ApiInterceptor(),
      ),
    );

    ExchangeInjection.configure(getIt);
  }
}
