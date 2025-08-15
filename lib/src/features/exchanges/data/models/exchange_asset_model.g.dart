// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeAssetModel _$ExchangeAssetModelFromJson(Map<String, dynamic> json) =>
    ExchangeAssetModel(
      walletAddress: json['wallet_address'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      platform: json['platform'] == null
          ? null
          : PlatformModel.fromJson(json['platform'] as Map<String, dynamic>),
      currency: CurrencyModel.fromJson(
        json['currency'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ExchangeAssetModelToJson(ExchangeAssetModel instance) =>
    <String, dynamic>{
      'wallet_address': instance.walletAddress,
      'balance': instance.balance,
      'platform': instance.platform,
      'currency': instance.currency,
    };

PlatformModel _$PlatformModelFromJson(Map<String, dynamic> json) =>
    PlatformModel(
      cryptoId: (json['crypto_id'] as num).toInt(),
      symbol: json['symbol'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PlatformModelToJson(PlatformModel instance) =>
    <String, dynamic>{
      'crypto_id': instance.cryptoId,
      'symbol': instance.symbol,
      'name': instance.name,
    };

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      cryptoId: (json['crypto_id'] as num).toInt(),
      priceUsd: (json['price_usd'] as num?)?.toDouble(),
      symbol: json['symbol'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'crypto_id': instance.cryptoId,
      'price_usd': instance.priceUsd,
      'symbol': instance.symbol,
      'name': instance.name,
    };
