// Dart imports:
import 'dart:convert';

OwOResponse owOResponseFromJson(String str) =>
    OwOResponse.fromJson(json.decode(str));

String owOResponseToJson(OwOResponse data) => json.encode(data.toJson());

class OwOResponse {
  final bool success;
  final List<FileElement> files;

  OwOResponse({
    this.success,
    this.files,
  });

  factory OwOResponse.fromJson(Map<String, dynamic> json) => OwOResponse(
        success: json['success'],
        files: List<FileElement>.from(
            json['files'].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'files': List<dynamic>.from(files.map((x) => x.toJson())),
      };
}

class FileElement {
  final bool success;
  final String hash;
  final String name;
  final String url;
  final int size;

  FileElement({
    this.success,
    this.hash,
    this.name,
    this.url,
    this.size,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        success: json['success'],
        hash: json['hash'],
        name: json['name'],
        url: json['url'],
        size: json['size'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'hash': hash,
        'name': name,
        'url': url,
        'size': size,
      };
}
