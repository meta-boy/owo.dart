import 'dart:convert';

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

// Project imports:
import 'core/errors/exceptions.dart';
import 'core/errors/failures.dart';
import 'core/models/objects_model.dart';
import 'core/models/response_model.dart';
import 'utils/constants.dart';
import 'utils/functions.dart';

/// Client class
class OwOClient {
  String _apiKey;
  final String customUrl;
  var headers;

  OwOClient({
    @required apiKey,
    this.customUrl,
  }) {
    _apiKey = apiKey;
  }

  /// Initialize the headers with Client version and api
  Future init() async {
    headers = {
      'Authorization': _apiKey,
      'User-Agent':
          'WhatsThisClient (https://owo.codes/source/owo.dart v1.0.6)',
    };
  }

  /// if statusCode for the response is 200, returns [OwOResponse]
  /// else returns [OwOFailure]
  Future<Either<OwOFailure, OwOResponse>> upload(
      {@required List<File> files, bool associated = false}) async {
    if (files.length > maxFiles) {
      throw FileException(
          message: 'Maximum $maxFiles are to be uploaded at a time.');
    }
    var request = http.MultipartRequest('POST',
        Uri.parse(baseUrl + uploadPath + (associated ? '/associated' : '')));
    for (var file in files) {
      await validFile(file: file);
      request.files
          .add(await http.MultipartFile.fromPath('files[]', file.path));
    }

    request.headers.addAll(headers);
    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      var owoObject = await owOResponseFromJson(response.body);
      owoObject =
          await responseWithUploadUrl(response: owoObject, url: customUrl);
      return Right(owoObject);
    } else {
      return Left(owOFailureFromJson(response.body));
    }
  }

  /// Shorten the provided URL
  Future<Either<OwOFailure, String>> shorten(
      {@required String url, bool associated = false}) async {
    var response = await http.get(
        baseUrl +
            shortenPath +
            (associated ? '/associated' : '') +
            '?action=shorten&url=${Uri.parse(url)}',
        headers: headers);
    if (response.statusCode == 200) {
      var ree =
          await customShorten(response.body.split('/').last, url: customUrl);
      return Right(ree);
    } else {
      return Left(owOFailureFromJson(response.body));
    }
  }

  /// Getting an object with specified key

  Future<Either<OwOFailure, OwOObject>> getObject(
      {@required String key}) async {
    var response =
        await http.get(baseUrl + objectsPath + '/$key', headers: headers);

    if (response.statusCode == 200) {
      return Right(owOObjectFromJson(response.body));
    } else {
      return Left(owOFailureFromJson(response.body));
    }
  }

  /// Deleting an object with specfied key

  Future<Either<OwOFailure, OwOObject>> deleteObject(
      {@required String key}) async {
    var response =
        await http.delete(baseUrl + objectsPath + '/$key', headers: headers);

    if (response.statusCode == 200) {
      return Right(owOObjectFromJson(response.body));
    } else {
      return Left(owOFailureFromJson(response.body));
    }
  }

  /// Get all (with constraints) objects for the [_apiKey] in context.

  Future<Either<OwOFailure, OwOObjects>> getAllObjects(
      {int offset = 0, int limit = 100}) async {
    var response = await http.get(
        baseUrl + objectsPath + '?offset=$offset&limit=$limit',
        headers: headers);

    if (response.statusCode == 200) {
      return Right(owOObjectsFromJson(response.body));
    } else {
      return Left(owOFailureFromJson(response.body));
    }
  }

  OwOClient copyWith({
    String customUrl,
  }) {
    return OwOClient(
      customUrl: customUrl ?? this.customUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customUrl': customUrl,
    };
  }

  static OwOClient fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OwOClient(
      customUrl: map['customUrl'],
      apiKey: null,
    );
  }

  String toJson() => json.encode(toMap());

  static OwOClient fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'OwOClient(customUrl: $customUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OwOClient && o.customUrl == customUrl;
  }

  @override
  int get hashCode => customUrl.hashCode;
}
