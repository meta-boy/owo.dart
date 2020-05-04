// To parse this JSON data, do
//
//     final owOObject = owOObjectFromJson(jsonString);

import 'dart:convert';

OwOObject owOObjectFromJson(String str) => OwOObject.fromJson(json.decode(str));

String owOObjectToJson(OwOObject data) => json.encode(data.toJson());

class OwOObject {
  final bool success;
  final Data data;

  OwOObject({
    this.success,
    this.data,
  });

  factory OwOObject.fromJson(Map<String, dynamic> json) => OwOObject(
        success: json['success'],
        data: Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data.toJson(),
      };
}

class Data {
  final String bucket;
  final String key;
  final String dir;
  final int type;
  final String destUrl;
  final dynamic contentType;
  final dynamic contentLength;
  final DateTime createdAt;
  final dynamic deletedAt;
  final dynamic deleteReason;
  final dynamic md5Hash;
  final dynamic sha256Hash;
  final bool associatedWithCurrentUser;

  Data({
    this.bucket,
    this.key,
    this.dir,
    this.type,
    this.destUrl,
    this.contentType,
    this.contentLength,
    this.createdAt,
    this.deletedAt,
    this.deleteReason,
    this.md5Hash,
    this.sha256Hash,
    this.associatedWithCurrentUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bucket: json['bucket'],
        key: json['key'],
        dir: json['dir'],
        type: json['type'],
        destUrl: json['dest_url'],
        contentType: json['content_type'],
        contentLength: json['content_length'],
        createdAt: DateTime.parse(json['created_at']),
        deletedAt: json['deleted_at'],
        deleteReason: json['delete_reason'],
        md5Hash: json['md5_hash'],
        sha256Hash: json['sha256_hash'],
        associatedWithCurrentUser: json['associated_with_current_user'],
      );

  Map<String, dynamic> toJson() => {
        'bucket': bucket,
        'key': key,
        'dir': dir,
        'type': type,
        'dest_url': destUrl,
        'content_type': contentType,
        'content_length': contentLength,
        'created_at': createdAt.toIso8601String(),
        'deleted_at': deletedAt,
        'delete_reason': deleteReason,
        'md5_hash': md5Hash,
        'sha256_hash': sha256Hash,
        'associated_with_current_user': associatedWithCurrentUser,
      };
}

OwOObjects owOObjectsFromJson(String str) => OwOObjects.fromJson(json.decode(str));

String owOObjectsToJson(OwOObjects data) => json.encode(data.toJson());

class OwOObjects {
    final bool success;
    final List<Datum> data;

    OwOObjects({
        this.success,
        this.data,
    });

    factory OwOObjects.fromJson(Map<String, dynamic> json) => OwOObjects(
        success: json['success'],
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String bucket;
    final String key;
    final String dir;
    final int type;
    final dynamic destUrl;
    final String contentType;
    final int contentLength;
    final DateTime createdAt;
    final dynamic deletedAt;
    final dynamic deleteReason;
    final String md5Hash;
    final String sha256Hash;
    final bool associatedWithCurrentUser;

    Datum({
        this.bucket,
        this.key,
        this.dir,
        this.type,
        this.destUrl,
        this.contentType,
        this.contentLength,
        this.createdAt,
        this.deletedAt,
        this.deleteReason,
        this.md5Hash,
        this.sha256Hash,
        this.associatedWithCurrentUser,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bucket: json['bucket'],
        key: json['key'],
        dir: json['dir'],
        type: json['type'],
        destUrl: json['dest_url'],
        contentType: json['content_type'],
        contentLength: json['content_length'],
        createdAt: DateTime.parse(json['created_at']),
        deletedAt: json['deleted_at'],
        deleteReason: json['delete_reason'],
        md5Hash: json['md5_hash'],
        sha256Hash: json['sha256_hash'],
        associatedWithCurrentUser: json['associated_with_current_user'],
    );

    Map<String, dynamic> toJson() => {
        'bucket': bucket,
        'key': key,
        'dir': dir,
        'type': type,
        'dest_url': destUrl,
        'content_type': contentType,
        'content_length': contentLength,
        'created_at': createdAt.toIso8601String(),
        'deleted_at': deletedAt,
        'delete_reason': deleteReason,
        'md5_hash': md5Hash,
        'sha256_hash': sha256Hash,
        'associated_with_current_user': associatedWithCurrentUser,
    };
}
