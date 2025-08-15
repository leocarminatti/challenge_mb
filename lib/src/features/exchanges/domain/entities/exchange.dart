import 'package:equatable/equatable.dart';

class Exchange extends Equatable {
  final String id;
  final String name;
  final String? logo;
  final String? description;
  final String? url;
  final double? makerFee;
  final double? takerFee;
  final DateTime? dateLaunched;
  final double? spotVolumeUsd;

  const Exchange({
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

  @override
  List<Object?> get props => [
    id,
    name,
    logo,
    description,
    url,
    makerFee,
    takerFee,
    dateLaunched,
    spotVolumeUsd,
  ];

  Exchange copyWith({
    String? id,
    String? name,
    String? logo,
    String? description,
    String? url,
    double? makerFee,
    double? takerFee,
    DateTime? dateLaunched,
    double? spotVolumeUsd,
  }) {
    return Exchange(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      description: description ?? this.description,
      url: url ?? this.url,
      makerFee: makerFee ?? this.makerFee,
      takerFee: takerFee ?? this.takerFee,
      dateLaunched: dateLaunched ?? this.dateLaunched,
      spotVolumeUsd: spotVolumeUsd ?? this.spotVolumeUsd,
    );
  }
}
