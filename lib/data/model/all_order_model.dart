// To parse this JSON data, do
//
//     final allOrderModel = allOrderModelFromJson(jsonString);

import 'dart:convert';

AllOrderModel allOrderModelFromJson(String str) => AllOrderModel.fromJson(json.decode(str));

String allOrderModelToJson(AllOrderModel data) => json.encode(data.toJson());

class AllOrderModel {
  final bool? success;
  final int? totalOrders;
  final List<OrderItem>? data;

  AllOrderModel({
    this.success,
    this.totalOrders,
    this.data,
  });

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
    success: json["success"],
    totalOrders: json["totalOrders"],
    data: json["data"] == null ? [] : List<OrderItem>.from(json["data"]!.map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "totalOrders": totalOrders,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrderItem {
  final int? id;
  final String? company;
  final int? createdBy;
  final String? deliveryDate;
  final String? orderStatus;
  final String? paymentMethod;
  final double? subTotal;
  final double? tax;
  final double? taxAmount;
  final int? deliveryFee;
  final double? total;
  final int? userDeliveryAddressId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderProductItem>? products;
  final UserDeliveryAddress? userDeliveryAddress;

  OrderItem({
    this.id,
    this.company,
    this.createdBy,
    this.deliveryDate,
    this.orderStatus,
    this.paymentMethod,
    this.subTotal,
    this.tax,
    this.taxAmount,
    this.deliveryFee,
    this.total,
    this.userDeliveryAddressId,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.userDeliveryAddress,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    company: json["company"],
    createdBy: json["created_by"],
    deliveryDate: json["delivery_date"],
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"],
    subTotal: json["sub_total"]?.toDouble(),
    tax: json["tax"]?.toDouble(),
    taxAmount: json["tax_amount"]?.toDouble(),
    deliveryFee: json["delivery_fee"],
    total: json["total"]?.toDouble(),
    userDeliveryAddressId: json["user_delivery_address_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    products: json["products"] == null ? [] : List<OrderProductItem>.from(json["products"]!.map((x) => OrderProductItem.fromJson(x))),
    userDeliveryAddress: json["user_delivery_address"] == null ? null : UserDeliveryAddress.fromJson(json["user_delivery_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company,
    "created_by": createdBy,
    "delivery_date": deliveryDate,
    "order_status": orderStatus,
    "payment_method": paymentMethod,
    "sub_total": subTotal,
    "tax": tax,
    "tax_amount": taxAmount,
    "delivery_fee": deliveryFee,
    "total": total,
    "user_delivery_address_id": userDeliveryAddressId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "user_delivery_address": userDeliveryAddress?.toJson(),
  };
}

class OrderProductItem {
  final int? productId;
  final String? name;
  final int? quantity;
  final double? price;
  final List<Image>? images;

  OrderProductItem({
    this.productId,
    this.name,
    this.quantity,
    this.price,
    this.images,
  });

  factory OrderProductItem.fromJson(Map<String, dynamic> json) => OrderProductItem(
    productId: json["product_id"],
    name: json["name"],
    quantity: json["quantity"],
    price: json["price"]?.toDouble(),
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "name": name,
    "quantity": quantity,
    "price": price,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  final int? id;
  final String? imageUrl;

  Image({
    this.id,
    this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
  };
}

class UserDeliveryAddress {
  final String? phone;
  final String? contact;
  final String? address;
  final String? addressType;
  final String? city;
  final String? postCode;
  final String? message;

  UserDeliveryAddress({
    this.phone,
    this.contact,
    this.address,
    this.addressType,
    this.city,
    this.postCode,
    this.message,
  });

  factory UserDeliveryAddress.fromJson(Map<String, dynamic> json) => UserDeliveryAddress(
    phone: json["phone"],
    contact: json["contact"],
    address: json["address"],
    addressType: json["address_type"],
    city: json["city"],
    postCode: json["post_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "contact": contact,
    "address": address,
    "address_type": addressType,
    "city": city,
    "post_code": postCode,
    "message": message,
  };
}
