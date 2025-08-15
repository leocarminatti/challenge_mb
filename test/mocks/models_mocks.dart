import 'package:challenge_mb/src/features/exchanges/data/data.dart';

class ModelsMocks {
  static final exchangeMapModel = ExchangeMapModel(id: 1);

  static final exchangeModel = ExchangeModel(
    id: 'test-id',
    logo: 'https://example.com/logo.png',
    name: 'Test Exchange',
  );

  static final exchangeAssetModel = ExchangeAssetModel(
    walletAddress: '0x1234567890',
    balance: 1000.0,
    platform: PlatformModel(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
    currency: CurrencyModel(cryptoId: 1, symbol: 'BTC', name: 'Bitcoin'),
  );
}
