import 'package:json_annotation/json_annotation.dart';

part 'exchange_asset_model.g.dart';

@JsonSerializable()
class ExchangeAssetModel {
  @JsonKey(name: 'wallet_address')
  final String? walletAddress;
  final double? balance;
  final PlatformModel? platform;
  final CurrencyModel currency;

  const ExchangeAssetModel({
    this.walletAddress,
    this.balance,
    this.platform,
    required this.currency,
  });

  factory ExchangeAssetModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeAssetModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeAssetModelToJson(this);
}

@JsonSerializable()
class PlatformModel {
  @JsonKey(name: 'crypto_id')
  final int cryptoId;
  final String symbol;
  final String name;

  const PlatformModel({
    required this.cryptoId,
    required this.symbol,
    required this.name,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) =>
      _$PlatformModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformModelToJson(this);
}

@JsonSerializable()
class CurrencyModel {
  @JsonKey(name: 'crypto_id')
  final int cryptoId;
  @JsonKey(name: 'price_usd')
  final double? priceUsd;
  final String symbol;
  final String name;

  const CurrencyModel({
    required this.cryptoId,
    this.priceUsd,
    required this.symbol,
    required this.name,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}
