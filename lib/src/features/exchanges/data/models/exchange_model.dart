import 'package:json_annotation/json_annotation.dart';

part 'exchange_model.g.dart';

@JsonSerializable()
class ExchangeModel {
  final String id;
  final String name;
  final String? logo;
  final String? description;
  final String? url;
  @JsonKey(name: 'maker_fee')
  final double? makerFee;
  @JsonKey(name: 'taker_fee')
  final double? takerFee;
  @JsonKey(name: 'date_launched')
  final String? dateLaunched;
  @JsonKey(name: 'spot_volume_usd')
  final double? spotVolumeUsd;

  const ExchangeModel({
    required this.id,
    required this.name,
    this.logo,
    this.description,
    this.url,
    this.makerFee,
    this.takerFee,
    this.dateLaunched,
    this.spotVolumeUsd,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    String? websiteUrl;
    if (json['urls'] is Map<String, dynamic>) {
      final urls = json['urls'] as Map<String, dynamic>;
      if (urls['website'] is List && (urls['website'] as List).isNotEmpty) {
        websiteUrl = urls['website'][0] as String?;
      }
    }

    String exchangeId;
    if (json['id'] is String) {
      exchangeId = json['id'] as String;
    } else if (json['id'] is int) {
      exchangeId = (json['id'] as int).toString();
    } else if (json['id'] is num) {
      exchangeId = (json['id'] as num).toString();
    } else {
      exchangeId = json['id'].toString();
    }

    return ExchangeModel(
      id: exchangeId,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      description: json['description'] as String?,
      url: websiteUrl ?? json['url'] as String?,
      makerFee: json['maker_fee']?.toDouble(),
      takerFee: json['taker_fee']?.toDouble(),
      dateLaunched: json['date_launched'] as String?,
      spotVolumeUsd: json['spot_volume_usd']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => _$ExchangeModelToJson(this);
}
