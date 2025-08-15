import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/exchange_repository.dart';

class GetExchangesByIdsUseCase {
  final ExchangeRepository _repository;

  const GetExchangesByIdsUseCase(this._repository);

  Future<Either<Failure, List<Exchange>>> call({int? start, int? limit}) async {
    final exchangeMapResult = await _repository.getExchangeMap(start, limit);

    return await exchangeMapResult.fold((failure) => Left(failure), (
      exchangeMapList,
    ) async {
      final exchangeIds = exchangeMapList.map((e) => e.id).toList();
      return await _repository.getMultipleExchangeDetails(exchangeIds);
    });
  }
}
