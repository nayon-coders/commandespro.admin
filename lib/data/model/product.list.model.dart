// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  final bool? success;
  final String? message;
  final int? totalProducts;
  final List<SingleProducts>? data;

  ProductListModel({
    this.success,
    this.message,
    this.totalProducts,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    success: json["success"],
    message: json["message"],
    totalProducts: json["totalProducts"],
    data: json["data"] == null ? [] : List<SingleProducts>.from(json["data"]!.map((x) => SingleProducts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "totalProducts": totalProducts,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleProducts {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? productType;
  final String? unit;
  final String? longDescription;
  final String? shortDescription;
  final String? status;
  final double? tax;
  final String? country;
  final int? isStock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic purchasePrice;
  final dynamic supper_marcent;
  final double? regularPrice;
  final double? sellingPrice;
  final double? wholePrice;
  final double? discountPrice;
  final String? categoryImage;
  final String? categoryName;
  final List<ProductImages>? images;
  final List<Variant>? variants;
  final List<Subcategory>? subcategories;
  final List<String>? tags;

  SingleProducts({
    this.id,
    this.categoryId,
    this.name,
    this.productType,
    this.unit,
    this.longDescription,
    this.shortDescription,
    this.status,
    this.tax,
    this.country,
    this.isStock,
    this.createdAt,
    this.updatedAt,
    this.purchasePrice,
    this.regularPrice,
    this.sellingPrice,
    this.wholePrice,
    this.discountPrice,
    this.categoryImage,
    this.categoryName,
    this.images,
    this.variants,
    this.subcategories,
    this.tags,
    this.supper_marcent
  });

  factory SingleProducts.fromJson(Map<String, dynamic> json) => SingleProducts(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    productType: json["product_type"],
    unit: json["unit"],
    longDescription: json["long_description"],
    shortDescription: json["short_description"],
    status: json["status"],
    tax: json["tax"]?.toDouble(),
    country: json["country"],
    isStock: json["is_stock"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    purchasePrice: json["purchase_price"],
    supper_marcent: json["supper_marcent"],
    regularPrice: json["regular_price"]?.toDouble(),
    sellingPrice: json["selling_price"]?.toDouble(),
    wholePrice: json["whole_price"]?.toDouble(),
    discountPrice: json["discount_price"]?.toDouble(),
    categoryImage: json["category_image"],
    categoryName: json["category_name"],
    images: json["images"] == null ? [] : List<ProductImages>.from(json["images"]!.map((x) => ProductImages.fromJson(x))),
    variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
    subcategories: json["subcategories"] == null
        ? []
        : (json["subcategories"] as List).where((x) => x != null).map((x) => Subcategory.fromJson(x)).toList(),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "product_type": productType,
    "unit": unit,
    "long_description": longDescription,
    "short_description": shortDescription,
    "status": status,
    "tax": tax,
    "country": country,
    "is_stock": isStock,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "purchase_price": purchasePrice,
    "regular_price": regularPrice,
    "selling_price": sellingPrice,
    "whole_price": wholePrice,
    "discount_price": discountPrice,
    "category_image": categoryImage,
    "category_name": categoryName,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
    "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class ProductImages {
  final int? imageId;
  final String? imageUrl;

  ProductImages({
    this.imageId,
    this.imageUrl,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
    imageId: json["image_id"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
    "image_url": imageUrl,
  };
}

class Subcategory {
  final int? subCategoryId;
  final String? subCategoryImage;
  final String? subCategoryName;

  Subcategory({
    this.subCategoryId,
    this.subCategoryImage,
    this.subCategoryName,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    subCategoryId: json["subCategory_id"],
    subCategoryImage: json["subCategory_image"],
    subCategoryName: json["subCategory_name"],
  );

  Map<String, dynamic> toJson() => {
    "subCategory_id": subCategoryId,
    "subCategory_image": subCategoryImage,
    "subCategory_name": subCategoryName,
  };
}

class Variant {
  final int? variantId;
  final String? variantName;
  final String? variantValue;

  Variant({
    this.variantId,
    this.variantName,
    this.variantValue,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    variantId: json["variant_id"],
    variantName: json["variant_name"],
    variantValue: json["variant_value"],
  );

  Map<String, dynamic> toJson() => {
    "variant_id": variantId,
    "variant_name": variantName,
    "variant_value": variantValue,
  };
}
