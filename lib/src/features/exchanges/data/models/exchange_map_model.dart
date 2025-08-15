import 'package:json_annotation/json_annotation.dart';

part 'exchange_map_model.g.dart';

@JsonSerializable()
class ExchangeMapModel {
  final int id;

  const ExchangeMapModel({required this.id});

  factory ExchangeMapModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeMapModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeMapModelToJson(this);
}
