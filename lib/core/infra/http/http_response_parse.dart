mixin HttpResponseParse {
  List<T> parseListResponse<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
    String dataTypeName,
  ) {
    try {
      if (json is List) {
        return json.map((item) {
          if (item is Map<String, dynamic>) {
            return fromJson(item);
          } else {
            throw FormatException('Item não é um Map<String, dynamic>: $item');
          }
        }).toList();
      }

      if (json is Map<String, dynamic> && json.containsKey('data')) {
        final data = json['data'];

        if (data is List) {
          return data.map((item) {
            if (item is Map<String, dynamic>) {
              return fromJson(item);
            } else {
              throw FormatException(
                'Item da lista não é um Map<String, dynamic>: $item',
              );
            }
          }).toList();
        }

        if (data is Map<String, dynamic>) {
          return data.values.map((item) {
            if (item is Map<String, dynamic>) {
              return fromJson(item);
            } else {
              throw FormatException(
                'Item do map não é um Map<String, dynamic>: $item',
              );
            }
          }).toList();
        }
      }

      if (json is Map<String, dynamic>) {
        return [fromJson(json)];
      }

      throw FormatException(
        'Formato de resposta inválido para $dataTypeName: ${json.runtimeType}',
      );
    } catch (e) {
      throw FormatException('Erro ao fazer parse de $dataTypeName: $e');
    }
  }

  T parseSingleResponse<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
    String dataTypeName,
  ) {
    if (json is Map<String, dynamic> && json.containsKey('data')) {
      final data = json['data'];

      if (data is Map<String, dynamic>) {
        if (data.isNotEmpty) {
          final firstKey = data.keys.first;
          final firstValue = data[firstKey];

          if (firstValue is Map<String, dynamic>) {
            return fromJson(firstValue);
          }
        }
      }

      if (data is List && data.isNotEmpty) {
        return fromJson(data.first);
      }
    }

    if (json is Map<String, dynamic>) {
      return fromJson(json);
    }

    if (json is List && json.isNotEmpty) {
      return fromJson(json.first);
    }

    throw FormatException('Formato de resposta inválido para $dataTypeName');
  }
}
