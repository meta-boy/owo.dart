import 'package:meta/meta.dart';

class FileException implements Exception {
  final String message;

  FileException({@required this.message}): assert(message != null);

  @override
  String toString() => 'FileException(message: $message)';
}

class InvalidUrlException implements Exception {
  final String message;

  InvalidUrlException({@required this.message}): assert(message != null);


  @override
  String toString() => 'InvalidUrl(message: $message)';
}
