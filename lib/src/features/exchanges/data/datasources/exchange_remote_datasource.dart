import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../models/models.dart';

abstract class ExchangeRemoteDataSource {
  Future<Either<Failure, List<ExchangeMapModel>>> getExchangeMap([
    int? start,
    int? limit,
  ]);
  Future<Either<Failure, ExchangeModel>> getExchangeDetails(String exchangeId);
  Future<Either<Failure, List<ExchangeModel>>> getMultipleExchangeDetails(
    List<String> exchangeIds,
  );
  Future<Either<Failure, List<ExchangeAssetModel>>> getExchangeAssets(
    String exchangeId, [
    int? start,
    int? limit,
  ]);
}

class ExchangeRemoteDataSourceImpl
    with HttpResponseParse
    implements ExchangeRemoteDataSource {
  final HttpClient httpClient;
  ExchangeRemoteDataSourceImpl(this.httpClient);

  @override
  Future<Either<Failure, List<ExchangeMapModel>>> getExchangeMap([
    int? start,
    int? limit,
  ]) async {
    try {
      if (start != null && start < 1) {
        return Left(DataParsingFailure('Start deve ser maior que 0'));
      }
      if (limit != null && (limit < 1 || limit > 5000)) {
        return Left(DataParsingFailure('Limit deve estar entre 1 e 5000'));
      }

      final queryParams = <String, String>{};
      if (start != null) queryParams['start'] = start.toString();
      if (limit != null) queryParams['limit'] = limit.toString();
      queryParams['sort'] = 'volume_24h';

      final response = await httpClient.get(
        '/exchange/map',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      return Right(
        parseListResponse<ExchangeMapModel>(
          response.data,
          ExchangeMapModel.fromJson,
          'lista de exchange map',
        ),
      );
    } on HttpError catch (e) {
      return Left(ServerFailure(e.data, statusCode: e.statusCode));
    } catch (e) {
      return Left(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExchangeModel>> getExchangeDetails(
    String exchangeId,
  ) async {
    try {
      if (exchangeId.isEmpty) {
        return Left(DataParsingFailure('Exchange ID não pode ser vazio'));
      }

      final response = await httpClient.get(
        '/exchange/info',
        queryParameters: {'id': exchangeId},
      );

      return Right(
        parseSingleResponse<ExchangeModel>(
          response.data,
          ExchangeModel.fromJson,
          'exchange individual',
        ),
      );
    } on HttpError catch (e) {
      return Left(ServerFailure(e.data, statusCode: e.statusCode));
    } catch (e) {
      return Left(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExchangeModel>>> getMultipleExchangeDetails(
    List<String> exchangeIds,
  ) async {
    try {
      if (exchangeIds.isEmpty) {
        return Left(
          DataParsingFailure('Lista de Exchange IDs não pode ser vazia'),
        );
      }

      final validIds = exchangeIds.where((id) => id.isNotEmpty).toList();
      if (validIds.isEmpty) {
        return Left(DataParsingFailure('Nenhum Exchange ID válido fornecido'));
      }

      final idsParam = validIds.join(',');

      final response = await httpClient.get(
        '/exchange/info',
        queryParameters: {'id': idsParam},
      );

      return Right(
        parseListResponse<ExchangeModel>(
          response.data,
          ExchangeModel.fromJson,
          'múltiplas exchanges',
        ),
      );
    } on HttpError catch (e) {
      return Left(ServerFailure(e.data, statusCode: e.statusCode));
    } catch (e) {
      return Left(DataParsingFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExchangeAssetModel>>> getExchangeAssets(
    String exchangeId, [
    int? start,
    int? limit,
  ]) async {
    try {
      if (exchangeId.isEmpty) {
        return Left(DataParsingFailure('Exchange ID não pode ser vazio'));
      }

      final queryParams = <String, String>{'id': exchangeId};

      final response = await httpClient.get(
        '/exchange/assets',
        queryParameters: queryParams,
      );

      return Right(
        parseListResponse<ExchangeAssetModel>(
          response.data,
          ExchangeAssetModel.fromJson,
          'lista de assets da exchange',
        ),
      );
    } on HttpError catch (e) {
      return Left(ServerFailure(e.data, statusCode: e.statusCode));
    } catch (e) {
      return Left(DataParsingFailure(e.toString()));
    }
  }
}
