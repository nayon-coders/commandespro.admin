class AdminProfileModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? roleName;
  final String? password;
  final List<Permission>? permissions;

  AdminProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.roleName,
    this.password,
    this.permissions,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) => AdminProfileModel(
    id: json["id"],
    firstName: json["first_name"] ?? "",  // Handle null by returning an empty string
    lastName: json["last_name"] ?? "",   // Handle null by returning an empty string
    email: json["email"] ?? "",          // Handle null by returning an empty string
    roleName: json["role_name"] ?? "",   // Handle null by returning an empty string
    password: json["password"] ?? "",    // Handle null by returning an empty string
    permissions: json["permissions"] == null
        ? [] // Handle null by returning an empty list
        : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName ?? "",
    "last_name": lastName ?? "",
    "email": email ?? "",
    "role_name": roleName ?? "",
    "password": password ?? "",
    "permissions": permissions == null
        ? [] // Handle null by returning an empty list
        : List<dynamic>.from(permissions!.map((x) => x.toJson())),
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
    section: json["section"] ?? "",  // Handle null by returning an empty string
    name: json["name"] == null
        ? [] // Handle null by returning an empty list
        : List<String>.from(json["name"]!.map((x) => x ?? "")),
  );

  Map<String, dynamic> toJson() => {
    "section": section ?? "",
    "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
  };
}
