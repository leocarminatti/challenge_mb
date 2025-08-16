import 'package:challenge_mb/core/infra/di/injector.dart';

import '../../domain/repositories/exchange_repository.dart';
import '../../domain/usecases/get_exchange_assets_stream_usecase.dart';
import 'exchange_details_bloc.dart';

class ExchangeDetailsBlocFactory {
  static ExchangeDetailsBloc create() {
    final repository = getIt<ExchangeRepository>();
    final useCase = GetExchangeAssetsStreamUseCase(repository);
    return ExchangeDetailsBloc(useCase);
  }
}
