// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeModel _$ExchangeModelFromJson(Map<String, dynamic> json) =>
    ExchangeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      makerFee: (json['maker_fee'] as num?)?.toDouble(),
      takerFee: (json['taker_fee'] as num?)?.toDouble(),
      dateLaunched: json['date_launched'] as String?,
      spotVolumeUsd: (json['spot_volume_usd'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ExchangeModelToJson(ExchangeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'description': instance.description,
      'url': instance.url,
      'maker_fee': instance.makerFee,
      'taker_fee': instance.takerFee,
      'date_launched': instance.dateLaunched,
      'spot_volume_usd': instance.spotVolumeUsd,
    };
