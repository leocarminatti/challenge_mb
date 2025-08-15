import 'package:challenge_mb/core/infra/di/injector.dart';

import '../../domain/repositories/exchange_repository.dart';
import '../../domain/usecases/usecases.dart';
import 'exchanges_bloc.dart';

class ExchangesBlocFactory {
  static ExchangesBloc create() {
    final repository = getIt<ExchangeRepository>();
    final useCase = GetExchangesByIdsUseCaseFactory.create(repository);
    return ExchangesBloc(useCase);
  }
}

class GetExchangesByIdsUseCaseFactory {
  static GetExchangesByIdsUseCase create(ExchangeRepository repository) {
    return GetExchangesByIdsUseCase(repository);
  }
}
