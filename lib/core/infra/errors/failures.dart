abstract class Failure implements Exception {
  final String message;
  final int? statusCode;

  Failure(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message';
}

class CacheFailure extends Failure {
  CacheFailure(super.message, {super.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message, {super.statusCode});
}

class DataParsingFailure extends Failure {
  DataParsingFailure(super.message, {super.statusCode});
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.message, {super.statusCode});
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message, {super.statusCode});
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.message, {super.statusCode});
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure(super.message, {super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure(super.message, {super.statusCode});
}
