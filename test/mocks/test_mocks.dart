import 'package:challenge_mb/core/infra/http/http_client.dart';
import 'package:challenge_mb/src/features/exchanges/data/datasources/exchange_remote_datasource.dart';
import 'package:challenge_mb/src/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchange_assets_stream_usecase.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchange_map_usecase.dart';
import 'package:challenge_mb/src/features/exchanges/domain/usecases/get_exchanges_by_ids_usecase.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchange_details_bloc.dart';
import 'package:challenge_mb/src/features/exchanges/presentation/bloc/exchanges_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockExchangeRepository extends Mock implements ExchangeRepository {}

class MockExchangeRemoteDataSource extends Mock
    implements ExchangeRemoteDataSource {}

class MockGetExchangeMapUseCase extends Mock implements GetExchangeMapUseCase {}

class MockGetExchangesByIdsUseCase extends Mock
    implements GetExchangesByIdsUseCase {}

class MockGetExchangeAssetsStreamUseCase extends Mock
    implements GetExchangeAssetsStreamUseCase {}

class MockExchangesBloc extends Mock implements ExchangesBloc {}

class MockExchangeDetailsBloc extends Mock implements ExchangeDetailsBloc {}

class TestMocks {
  static HttpClient createMockHttpClient() {
    return MockHttpClient();
  }

  static ExchangeRepository createMockExchangeRepository() {
    return MockExchangeRepository();
  }

  static ExchangeRemoteDataSource createMockExchangeRemoteDataSource() {
    return MockExchangeRemoteDataSource();
  }

  static GetExchangeMapUseCase createMockGetExchangeMapUseCase() {
    return MockGetExchangeMapUseCase();
  }

  static GetExchangesByIdsUseCase createMockGetExchangesByIdsUseCase() {
    return MockGetExchangesByIdsUseCase();
  }

  static GetExchangeAssetsStreamUseCase
  createMockGetExchangeAssetsStreamUseCase() {
    return MockGetExchangeAssetsStreamUseCase();
  }

  static void setupDataSourceMocks(MockHttpClient mockHttpClient) {}

  static void setupRepositoryMocks(MockExchangeRepository mockRepository) {}

  static void setupUseCaseMocks(
    MockGetExchangeMapUseCase mockGetExchangeMapUseCase,
    MockGetExchangesByIdsUseCase mockGetExchangesByIdsUseCase,
  ) {}
}
