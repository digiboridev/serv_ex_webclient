class UnexistedResource implements Exception {
  final String message;

  const UnexistedResource([this.message = '']);

  @override
  String toString() => 'UnexistedResource: $message';
}

class PermissionDenied implements Exception {
  final String message;

  const PermissionDenied([this.message = '']);

  @override
  String toString() => 'PermissionDenied: $message';
}

class Unauthorized implements Exception {
  final String message;

  const Unauthorized([this.message = '']);

  @override
  String toString() => 'Unauthorized: $message';
}
