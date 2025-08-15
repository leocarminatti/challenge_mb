import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/exchange_repository.dart';

class GetExchangeMapUseCase {
  final ExchangeRepository _repository;

  const GetExchangeMapUseCase(this._repository);

  Future<Either<Failure, List<ExchangeMap>>> call({
    int? start,
    int? limit,
  }) async {
    return await _repository.getExchangeMap(start, limit);
  }
}
