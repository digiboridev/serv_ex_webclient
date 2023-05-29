class InvalidArgument implements Exception {
  final String message;

  const InvalidArgument([this.message = '']);

  @override
  String toString() => 'InvalidArgument: $message';
}

class Unauthorized implements Exception {
  final String message;

  const Unauthorized([this.message = '']);

  @override
  String toString() => 'Unauthorized: $message';
}

class PermissionDenied implements Exception {
  final String message;

  const PermissionDenied([this.message = '']);

  @override
  String toString() => 'PermissionDenied: $message';
}

class UnexistedResource implements Exception {
  final String message;

  const UnexistedResource([this.message = '']);

  @override
  String toString() => 'UnexistedResource: $message';
}

class ServerError implements Exception {
  final String message;

  const ServerError([this.message = '']);

  @override
  String toString() => 'ServerError: $message';
}

class ConnectionError implements Exception {
  final String message;

  const ConnectionError([this.message = '']);

  @override
  String toString() => 'ConnectionError: $message';
}

class UnknownException implements Exception {
  final String message;

  const UnknownException([this.message = '']);

  @override
  String toString() => 'UnknownException: $message';
}
