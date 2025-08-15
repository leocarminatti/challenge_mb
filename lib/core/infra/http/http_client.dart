abstract class HttpClient {
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
  Future<HttpResponse> post(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  });
  Future<HttpResponse> put(
    String path, {
    dynamic body,
    Map<String, String>? headers,
  });
  Future<HttpResponse> delete(String path, {Map<String, String>? headers});
}

class HttpResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, String> headers;

  HttpResponse({
    required this.data,
    required this.statusCode,
    required this.headers,
  });
}
