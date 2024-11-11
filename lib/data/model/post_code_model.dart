// To parse this JSON data, do
//
//     final postcodeModel = postcodeModelFromJson(jsonString);

import 'dart:convert';

PostcodeModel postcodeModelFromJson(String str) => PostcodeModel.fromJson(json.decode(str));

String postcodeModelToJson(PostcodeModel data) => json.encode(data.toJson());

class PostcodeModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  PostcodeModel({
    this.success,
    this.message,
    this.data,
  });

  factory PostcodeModel.fromJson(Map<String, dynamic> json) => PostcodeModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final int? id;
  final String? code;

  Datum({
    this.id,
    this.code,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
  };
}
