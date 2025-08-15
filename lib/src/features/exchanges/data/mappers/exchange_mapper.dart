import '../../domain/entities/exchange.dart';
import '../models/exchange_model.dart';

class ExchangeMapper {
  static Exchange toEntity(ExchangeModel model) {
    return Exchange(
      id: model.id,
      name: model.name,
      logo: model.logo,
      description: model.description,
      url: model.url,
      makerFee: model.makerFee,
      takerFee: model.takerFee,
      dateLaunched: model.dateLaunched != null
          ? DateTime.tryParse(model.dateLaunched!)
          : null,
      spotVolumeUsd: model.spotVolumeUsd,
    );
  }

  static ExchangeModel toModel(Exchange entity) {
    return ExchangeModel(
      id: entity.id,
      name: entity.name,
      logo: entity.logo,
      description: entity.description,
      url: entity.url,
      makerFee: entity.makerFee,
      takerFee: entity.takerFee,
      dateLaunched: entity.dateLaunched?.toIso8601String(),
      spotVolumeUsd: entity.spotVolumeUsd,
    );
  }

  static List<Exchange> toEntityList(List<ExchangeModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static List<ExchangeModel> toModelList(List<Exchange> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}
