// To parse this JSON data, do
//
//     final adminRoleListModel = adminRoleListModelFromJson(jsonString);

import 'dart:convert';

AdminRoleListModel adminRoleListModelFromJson(String str) => AdminRoleListModel.fromJson(json.decode(str));

String adminRoleListModelToJson(AdminRoleListModel data) => json.encode(data.toJson());

class AdminRoleListModel {
  final bool? success;
  final String? message;
  final List<SingleAdminRole>? data;

  AdminRoleListModel({
    this.success,
    this.message,
    this.data,
  });

  factory AdminRoleListModel.fromJson(Map<String, dynamic> json) => AdminRoleListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleAdminRole>.from(json["data"]!.map((x) => SingleAdminRole.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleAdminRole {
  final int? id;
  final String? name;

  SingleAdminRole({
    this.id,
    this.name,
  });

  factory SingleAdminRole.fromJson(Map<String, dynamic> json) => SingleAdminRole(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
