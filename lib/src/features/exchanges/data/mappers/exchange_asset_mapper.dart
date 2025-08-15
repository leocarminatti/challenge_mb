import '../../domain/entities/exchange_asset.dart';
import '../models/exchange_asset_model.dart';

class ExchangeAssetMapper {
  static ExchangeAsset toEntity(ExchangeAssetModel model) {
    return ExchangeAsset(
      walletAddress: model.walletAddress,
      balance: model.balance,
      platform: model.platform != null
          ? PlatformMapper.toEntity(model.platform!)
          : null,
      currency: CurrencyMapper.toEntity(model.currency),
    );
  }

  static List<ExchangeAsset> toEntityList(List<ExchangeAssetModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static ExchangeAssetModel toModel(ExchangeAsset entity) {
    return ExchangeAssetModel(
      walletAddress: entity.walletAddress,
      balance: entity.balance,
      platform: entity.platform != null
          ? PlatformMapper.toModel(entity.platform!)
          : null,
      currency: CurrencyMapper.toModel(entity.currency),
    );
  }

  static List<ExchangeAssetModel> toModelList(List<ExchangeAsset> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}

class PlatformMapper {
  static Platform toEntity(PlatformModel model) {
    return Platform(
      cryptoId: model.cryptoId,
      symbol: model.symbol,
      name: model.name,
    );
  }

  static PlatformModel toModel(Platform entity) {
    return PlatformModel(
      cryptoId: entity.cryptoId,
      symbol: entity.symbol,
      name: entity.name,
    );
  }
}

class CurrencyMapper {
  static AssetCurrency toEntity(CurrencyModel model) {
    return AssetCurrency(
      cryptoId: model.cryptoId,
      priceUsd: model.priceUsd,
      symbol: model.symbol,
      name: model.name,
    );
  }

  static CurrencyModel toModel(AssetCurrency entity) {
    return CurrencyModel(
      cryptoId: entity.cryptoId,
      priceUsd: entity.priceUsd,
      symbol: entity.symbol,
      name: entity.name,
    );
  }
}
