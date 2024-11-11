// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  final bool? success;
  final String? message;
  final Data? data;

  PrivacyModel({
    this.success,
    this.message,
    this.data,
  });

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final String? privacy;
  final String? terms;
  final String? aboutUs;
  final String? legal;

  Data({
    this.id,
    this.privacy,
    this.terms,
    this.aboutUs,
    this.legal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    privacy: json["privacy"],
    terms: json["terms"],
    aboutUs: json["about_us"],
    legal: json["legal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "privacy": privacy,
    "terms": terms,
    "about_us": aboutUs,
    "legal": legal,
  };
}
