import '../../domain/entities/entities.dart';
import '../models/models.dart';

class ExchangeMapMapper {
  static ExchangeMap toEntity(ExchangeMapModel model) {
    return ExchangeMap(id: model.id.toString());
  }

  static List<ExchangeMap> toEntityList(List<ExchangeMapModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static ExchangeMapModel toModel(ExchangeMap entity) {
    return ExchangeMapModel(id: int.tryParse(entity.id) ?? 0);
  }

  static List<ExchangeMapModel> toModelList(List<ExchangeMap> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}
