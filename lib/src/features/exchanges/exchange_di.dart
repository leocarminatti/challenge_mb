import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/bloc/exchange_details_bloc.dart';
import 'presentation/bloc/exchange_details_bloc_factory.dart';
import 'presentation/bloc/exchanges_bloc.dart';
import 'presentation/bloc/exchanges_bloc_factory.dart';

class ExchangeInjection {
  static void configure(GetIt getIt) {
    _registerDataLayer(getIt);
    _registerUseCases(getIt);
    _registerBlocs(getIt);
  }

  static void _registerDataLayer(GetIt getIt) {
    getIt.registerLazySingleton<ExchangeRemoteDataSource>(
      () => ExchangeRemoteDataSourceImpl(getIt<HttpClient>()),
    );

    getIt.registerLazySingleton<ExchangeRepositoryImpl>(
      () => ExchangeRepositoryImpl(
        remoteDataSource: getIt<ExchangeRemoteDataSource>(),
      ),
    );

    getIt.registerLazySingleton<ExchangeRepository>(
      () => getIt<ExchangeRepositoryImpl>(),
    );
  }

  static void _registerUseCases(GetIt getIt) {
    getIt.registerLazySingleton<GetExchangeMapUseCase>(
      () => GetExchangeMapUseCase(getIt<ExchangeRepository>()),
    );

    getIt.registerLazySingleton<GetExchangeAssetsUseCase>(
      () => GetExchangeAssetsUseCase(getIt<ExchangeRepository>()),
    );

    getIt.registerLazySingleton<GetExchangesByIdsUseCase>(
      () => GetExchangesByIdsUseCase(getIt<ExchangeRepository>()),
    );
  }

  static void _registerBlocs(GetIt getIt) {
    getIt.registerLazySingleton<ExchangesBloc>(
      () => ExchangesBlocFactory.create(),
    );

    getIt.registerLazySingleton<ExchangeDetailsBloc>(
      () => ExchangeDetailsBlocFactory.create(),
    );
  }

  static void clear(GetIt getIt) {
    getIt.unregister<ExchangesBloc>();
    getIt.unregister<ExchangeDetailsBloc>();

    getIt.unregister<GetExchangeMapUseCase>();
    getIt.unregister<GetExchangeAssetsUseCase>();
    getIt.unregister<GetExchangesByIdsUseCase>();

    getIt.unregister<ExchangeRepositoryImpl>();
    getIt.unregister<ExchangeRemoteDataSource>();
  }
}
