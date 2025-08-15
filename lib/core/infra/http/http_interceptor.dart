import 'dart:convert';

import 'package:logger/logger.dart';

import '../../config/env_config.dart';
import '../errors/failures.dart';

abstract class HttpInterceptor {
  Future<Map<String, String>> onRequest(Map<String, String> headers);
  Future<void> onResponse(dynamic data, int statusCode);
  Future<void> onError(
    Failure error, {
    String? url,
    String? method,
    Map<String, String>? headers,
    dynamic requestBody,
    dynamic responseBody,
  });
}

class ApiInterceptor implements HttpInterceptor {
  final _logger = Logger();

  @override
  Future<Map<String, String>> onRequest(Map<String, String> headers) async {
    final enhancedHeaders = Map<String, String>.from(headers);

    enhancedHeaders['Accept'] = 'application/json';
    enhancedHeaders['Content-Type'] = 'application/json';

    try {
      if (EnvConfig.isInitialized) {
        final apiKey = EnvConfig.coinMarketCapApiKey;
        if (apiKey.isNotEmpty) {
          enhancedHeaders['X-CMC_PRO_API_KEY'] = apiKey;
        }
      }
    } catch (e) {
      _logger.w('Erro ao adicionar API Key do CoinMarketCap: $e');
    }

    _logRequest(enhancedHeaders);
    return enhancedHeaders;
  }

  @override
  Future<void> onResponse(dynamic data, int statusCode) async {
    _logResponse(statusCode, data);

    switch (statusCode) {
      case 400:
        await onError(
          BadRequestFailure(_getErrorMessage(data)),
          responseBody: data,
        );
        break;
      case 401:
        await onError(
          UnauthorizedFailure(_getErrorMessage(data)),
          responseBody: data,
        );
        break;
      case 403:
        await onError(
          ForbiddenFailure(_getErrorMessage(data)),
          responseBody: data,
        );
        break;
      case 429:
        await onError(
          TooManyRequestsFailure(_getErrorMessage(data)),
          responseBody: data,
        );
        break;
      case 500:
      case 502:
      case 503:
      default:
        await onError(
          ServerFailure(_getErrorMessage(data)),
          responseBody: data,
        );
        break;
    }
  }

  String _getErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'Erro desconhecido';
    }
    return data?.toString() ?? 'Erro desconhecido';
  }

  @override
  Future<void> onError(
    Failure error, {
    String? url,
    String? method,
    Map<String, String>? headers,
    dynamic requestBody,
    dynamic responseBody,
  }) async {
    _logger.d('''
      ERROR: ${error.toString()}
      URL: $url
      Method: $method
      Headers: ${_formatJson(headers)}
      Request Body: ${_formatJson(requestBody)}
      Response Body: ${_formatJson(responseBody)}
    ''');
  }

  void _logRequest(Map<String, String> headers) {
    _logger.d('''
      REQUEST
      Headers: ${_formatJson(headers)}
    ''');
  }

  void _logResponse(int statusCode, dynamic data) {
    _logger.d('''
      RESPONSE
      Status Code: $statusCode
      Body: ${_formatJson(data)}
    ''');
  }

  String _formatJson(dynamic data) {
    if (data == null) return 'null';
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (e) {
      return data.toString();
    }
  }
}
