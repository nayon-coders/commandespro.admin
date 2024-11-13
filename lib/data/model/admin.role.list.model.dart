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
  final int? roleId;
  final String? roleName;
  final List<Permission>? permissions;

  SingleAdminRole({
    this.roleId,
    this.roleName,
    this.permissions,
  });

  factory SingleAdminRole.fromJson(Map<String, dynamic> json) => SingleAdminRole(
    roleId: json["role_id"],
    roleName: json["role_name"],
    permissions: json["permissions"] == null ? [] : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "role_name": roleName,
    "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}

class Permission {
  final String? section;
  final List<String>? name;

  Permission({
    this.section,
    this.name,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    section: json["section"],
    name: json["name"] == null ? [] : List<String>.from(json["name"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "section": section,
    "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
  };
}
