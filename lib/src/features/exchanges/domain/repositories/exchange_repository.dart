import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../entities/entities.dart';

abstract class ExchangeRepository {
  Future<Either<Failure, List<ExchangeMap>>> getExchangeMap([
    int? start,
    int? limit,
  ]);
  Future<Either<Failure, Exchange>> getExchangeDetails(String exchangeId);
  Future<Either<Failure, List<Exchange>>> getMultipleExchangeDetails(
    List<String> exchangeIds,
  );
  Future<Either<Failure, List<ExchangeAsset>>> getExchangeAssets(
    String exchangeId, [
    int? start,
    int? limit,
  ]);
}
