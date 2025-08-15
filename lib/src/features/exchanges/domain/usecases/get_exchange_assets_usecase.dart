import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/exchange_repository.dart';

class GetExchangeAssetsUseCase {
  final ExchangeRepository _repository;

  const GetExchangeAssetsUseCase(this._repository);

  Future<Either<Failure, List<ExchangeAsset>>> call(
    String exchangeId, [
    int? start,
    int? limit,
  ]) async {
    return await _repository.getExchangeAssets(exchangeId, start, limit);
  }
}

class ExchangeDetailsWithAssets {
  final Exchange exchange;
  final List<ExchangeAsset> assets;

  const ExchangeDetailsWithAssets({
    required this.exchange,
    required this.assets,
  });

  ExchangeDetailsWithAssets copyWith({
    Exchange? exchange,
    List<ExchangeAsset>? assets,
  }) {
    return ExchangeDetailsWithAssets(
      exchange: exchange ?? this.exchange,
      assets: assets ?? this.assets,
    );
  }
}
