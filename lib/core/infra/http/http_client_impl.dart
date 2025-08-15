import 'dart:convert';

import 'package:http/http.dart' as http;

import 'http_client.dart';
import 'http_error.dart';
import 'http_interceptor.dart';

class HttpClientImpl implements HttpClient {
  final String baseUrl;
  final HttpInterceptor? interceptor;
  final http.Client _client;

  HttpClientImpl({required this.baseUrl, this.interceptor})
    : _client = http.Client();

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final modifiedHeaders = await _handleRequestHeaders(headers);

    final uri = Uri.parse(
      '$baseUrl$path',
    ).replace(queryParameters: queryParameters);

    final response = await _client.get(uri, headers: modifiedHeaders);
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final modifiedHeaders = await _handleRequestHeaders(headers);
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: modifiedHeaders,
    );
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> put(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final modifiedHeaders = await _handleRequestHeaders(headers);
    final response = await _client.put(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: modifiedHeaders,
    );
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> delete(
    String path, {
    Map<String, String>? headers,
  }) async {
    final modifiedHeaders = await _handleRequestHeaders(headers);
    final response = await _client.delete(
      Uri.parse('$baseUrl$path'),
      headers: modifiedHeaders,
    );
    return _handleResponse(response);
  }

  Future<Map<String, String>> _handleRequestHeaders(
    Map<String, String>? headers,
  ) async {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final mergedHeaders = {...defaultHeaders, ...?headers};

    if (interceptor != null) {
      return await interceptor!.onRequest(mergedHeaders);
    }

    return mergedHeaders;
  }

  Future<HttpResponse> _handleResponse(http.Response response) async {
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    if (interceptor != null) {
      await interceptor!.onResponse(responseData, response.statusCode);
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return HttpResponse(
        data: responseData,
        statusCode: response.statusCode,
        headers: response.headers,
      );
    }

    throw HttpError(
      data: responseData,
      statusCode: response.statusCode,
      headers: response.headers,
    );
  }
}
