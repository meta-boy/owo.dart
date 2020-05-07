// Dart imports:
import 'dart:convert';

OwOFailure owOFailureFromJson(String str) => OwOFailure.fromJson(json.decode(str));

String owOFailureToJson(OwOFailure data) => json.encode(data.toJson());

class OwOFailure {
    final bool success;
    final int errorcode;
    final String description;

    OwOFailure({
        this.success,
        this.errorcode,
        this.description,
    });

    factory OwOFailure.fromJson(Map<String, dynamic> json) => OwOFailure(
        success: json['success'],
        errorcode: json['errorcode'],
        description: json['description'],
    );

    Map<String, dynamic> toJson() => {
        'success': success,
        'errorcode': errorcode,
        'description': description,
    };
}
