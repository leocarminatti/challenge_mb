class HttpError implements Exception {
  final dynamic data;
  final int statusCode;
  final Map<String, String> headers;

  HttpError({
    required this.data,
    required this.statusCode,
    required this.headers,
  });

  @override
  String toString() {
    return 'HttpError: $statusCode\nData: $data';
  }
}
