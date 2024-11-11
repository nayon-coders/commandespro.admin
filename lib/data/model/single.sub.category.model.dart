// To parse this JSON data, do
//
//     final singleSubCategoryModel = singleSubCategoryModelFromJson(jsonString);

import 'dart:convert';

SingleSubCategoryModel singleSubCategoryModelFromJson(String str) => SingleSubCategoryModel.fromJson(json.decode(str));

String singleSubCategoryModelToJson(SingleSubCategoryModel data) => json.encode(data.toJson());

class SingleSubCategoryModel {
  final bool? success;
  final String? message;
  final Data? data;

  SingleSubCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  factory SingleSubCategoryModel.fromJson(Map<String, dynamic> json) => SingleSubCategoryModel(
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
  final String? categoryImage;
  final String? categoryName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SubCategory>? subCategories;

  Data({
    this.id,
    this.categoryImage,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.subCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    categoryImage: json["category_image"],
    categoryName: json["category_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subCategories: json["sub_categories"] == null ? [] : List<SubCategory>.from(json["sub_categories"]!.map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_image": categoryImage,
    "category_name": categoryName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sub_categories": subCategories == null ? [] : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
  };
}

class SubCategory {
  final int? id;
  final int? mainCatId;
  final String? image;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubCategory({
    this.id,
    this.mainCatId,
    this.image,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    mainCatId: json["main_cat_id"],
    image: json["image"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_cat_id": mainCatId,
    "image": image,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
