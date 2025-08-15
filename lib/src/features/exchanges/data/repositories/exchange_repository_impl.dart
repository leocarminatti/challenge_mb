import 'dart:isolate';

import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/exchange_repository.dart';
import '../datasources/datasources.dart';
import '../mappers/mappers.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSource _remoteDataSource;

  const ExchangeRepositoryImpl({
    required ExchangeRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<ExchangeMap>>> getExchangeMap([
    int? start,
    int? limit,
  ]) async {
    final remoteExchangeMapResult = await _remoteDataSource.getExchangeMap(
      start,
      limit,
    );

    return remoteExchangeMapResult.fold(
      (remoteFailure) => Left(remoteFailure),
      (remoteExchangeMap) =>
          Right(ExchangeMapMapper.toEntityList(remoteExchangeMap)),
    );
  }

  @override
  Future<Either<Failure, Exchange>> getExchangeDetails(
    String exchangeId,
  ) async {
    final remoteExchangeResult = await _remoteDataSource.getExchangeDetails(
      exchangeId,
    );

    return remoteExchangeResult.fold(
      (remoteFailure) => Left(remoteFailure),
      (remoteExchange) => Right(ExchangeMapper.toEntity(remoteExchange)),
    );
  }

  @override
  Future<Either<Failure, List<Exchange>>> getMultipleExchangeDetails(
    List<String> exchangeIds,
  ) async {
    final remoteExchangesResult = await _remoteDataSource
        .getMultipleExchangeDetails(exchangeIds);

    return remoteExchangesResult.fold(
      (remoteFailure) => Left(remoteFailure),
      (remoteExchanges) => Right(ExchangeMapper.toEntityList(remoteExchanges)),
    );
  }

  @override
  Future<Either<Failure, List<ExchangeAsset>>> getExchangeAssets(
    String exchangeId, [
    int? start,
    int? limit,
  ]) async {
    final remoteAssetsResult = await _remoteDataSource.getExchangeAssets(
      exchangeId,
      start,
      limit,
    );

    return remoteAssetsResult.fold((remoteFailure) => Left(remoteFailure), (
      remoteAssets,
    ) async {
      try {
        final assets = await Isolate.run(
          () => ExchangeAssetMapper.toEntityList(remoteAssets),
        );
        return Right(assets);
      } catch (e) {
        return Left(DataParsingFailure('Erro ao processar assets: $e'));
      }
    });
  }
}
