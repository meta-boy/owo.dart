// Package imports:
import 'package:meta/meta.dart';

/// Exception class to deal with custom [File] related errors
class FileException implements Exception {
  final String message;

  FileException({@required this.message}): assert(message != null);

  @override
  String toString() => 'FileException(message: $message)';
}

/// Exception class to deal with custom url related errors

class InvalidUrlException implements Exception {
  final String message;

  InvalidUrlException({@required this.message}): assert(message != null);


  @override
  String toString() => 'InvalidUrl(message: $message)';
}
