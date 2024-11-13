// To parse this JSON data, do
//
//     final allAdminListModel = allAdminListModelFromJson(jsonString);

import 'dart:convert';

AllAdminListModel allAdminListModelFromJson(String str) => AllAdminListModel.fromJson(json.decode(str));

String allAdminListModelToJson(AllAdminListModel data) => json.encode(data.toJson());

class AllAdminListModel {
  final bool? success;
  final String? message;
  final List<SingleAdmin>? data;

  AllAdminListModel({
    this.success,
    this.message,
    this.data,
  });

  factory AllAdminListModel.fromJson(Map<String, dynamic> json) => AllAdminListModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SingleAdmin>.from(json["data"]!.map((x) => SingleAdmin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleAdmin {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? roleName;
  final String? password;
  final List<Permission>? permissions;

  SingleAdmin({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.roleName,
    this.password,
    this.permissions,
  });

  factory SingleAdmin.fromJson(Map<String, dynamic> json) => SingleAdmin(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    roleName: json["role_name"],
    password: json["password"],
    permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "role_name": roleName,
    "password": password,
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}

class Permission {
  final String? section;
  final List<String?>? name;

  Permission({
    this.section,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    section: json["section"],
    name: json["name"] == null ? [] : List<String?>.from(json["name"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "section": section,
    "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
  };
}
