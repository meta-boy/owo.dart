import 'dart:io';

import 'package:meta/meta.dart';
import 'package:owo/src/core/errors/exceptions.dart';
import 'package:owo/src/core/models/response_model.dart';
import 'package:owo/src/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<bool> validFile({File file}) async {
  final fileLength = await file.length();
  if (fileLength > maxSize) {
    return throw FileException(
        message:
            'File ($fileLength) exceeds the maximum allowed size ($maxSize)');
  }
  return true;
}

Future<OwOResponse> responseWithUploadUrl(
    {@required OwOResponse response, String url}) async {
  var files = <FileElement>[];
  if (url != null) {
    if (!url.endsWith('/')) url += '/' + url;
    if (!url.startsWith('http')) {
      throw InvalidUrlException(
          message: 'Provided url does not start with http(s)');
    }
  }
  for (var file in response.files) {
    var f = FileElement(
        hash: file.hash,
        name: file.name,
        size: file.size,
        success: file.success,
        url: url ?? uploadStandard + file.url);
    files.add(f);
  }
  var owo = OwOResponse(success: response.success, files: files);
  return owo;
}

Future<List<String>> getAvailableUrls() async {
  var response = await http.get(domainsUrl);
  var urls = <String>[];
  for (var url in response.body.split('\n')) {
    if (!url.contains('#') && url.isNotEmpty) {
      urls.add('https://${url.split(':').last}/');
    }
  }

  return urls;
}