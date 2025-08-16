import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../domain.dart';

class GetExchangeAssetsStreamUseCase {
  final ExchangeRepository _repository;

  const GetExchangeAssetsStreamUseCase(this._repository);

  Stream<Either<Failure, List<ExchangeAsset>>> call(
    String exchangeId, {
    int chunkSize = 200,
  }) async* {
    try {
      final allAssetsResult = await _repository.getExchangeAssets(exchangeId);

      if (allAssetsResult.isLeft()) {
        yield allAssetsResult.fold(
          (failure) => Left<Failure, List<ExchangeAsset>>(failure),
          (_) => Left<Failure, List<ExchangeAsset>>(
            NetworkFailure('Unexpected success'),
          ),
        );
        return;
      }

      final allAssets = allAssetsResult.fold(
        (_) => <ExchangeAsset>[],
        (assets) => assets,
      );

      if (allAssets.isEmpty) {
        yield const Right<Failure, List<ExchangeAsset>>([]);
        return;
      }

      for (var i = 0; i < allAssets.length; i += chunkSize) {
        final end = (i + chunkSize < allAssets.length)
            ? i + chunkSize
            : allAssets.length;
        final chunk = allAssets.sublist(i, end);

        yield Right<Failure, List<ExchangeAsset>>(chunk);

        await Future.delayed(Duration.zero);
      }
    } catch (e) {
      yield Left<Failure, List<ExchangeAsset>>(NetworkFailure(e.toString()));
    }
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
