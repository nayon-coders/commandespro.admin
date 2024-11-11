// To parse this JSON data, do
//
//     final singleOrderModel = singleOrderModelFromJson(jsonString);

import 'dart:convert';

SingleOrderModel singleOrderModelFromJson(String str) => SingleOrderModel.fromJson(json.decode(str));

String singleOrderModelToJson(SingleOrderModel data) => json.encode(data.toJson());

class SingleOrderModel {
  final bool? success;
  final Order? order;

  SingleOrderModel({
    this.success,
    this.order,
  });

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) => SingleOrderModel(
    success: json["success"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "order": order?.toJson(),
  };
}

class Order {
  final int? id;
  final String? company;
  final int? createdBy;
  final DateTime? deliveryDate;
  final String? orderStatus;
  final String? paymentMethod;
  final int? subTotal;
  final int? tax;
  final int? taxAmount;
  final int? deliveryFee;
  final int? total;
  final int? userDeliveryAddressId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserInfo? userInfo;
  final List<Product>? products;
  final UserDeliveryAddress? userDeliveryAddress;

  Order({
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
    this.userInfo,
    this.products,
    this.userDeliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    company: json["company"],
    createdBy: json["created_by"],
    deliveryDate: json["delivery_date"] == null ? null : DateTime.parse(json["delivery_date"]),
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"],
    subTotal: json["sub_total"],
    tax: json["tax"],
    taxAmount: json["tax_amount"],
    deliveryFee: json["delivery_fee"],
    total: json["total"],
    userDeliveryAddressId: json["user_delivery_address_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    userDeliveryAddress: json["user_delivery_address"] == null ? null : UserDeliveryAddress.fromJson(json["user_delivery_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company,
    "created_by": createdBy,
    "delivery_date": "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
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
    "userInfo": userInfo?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "user_delivery_address": userDeliveryAddress?.toJson(),
  };
}

class Product {
  final int? productId;
  final dynamic name;
  final int? quantity;
  final double? price;
  final List<dynamic>? images;

  Product({
    this.productId,
    this.name,
    this.quantity,
    this.price,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    name: json["name"],
    quantity: json["quantity"],
    price: json["price"]?.toDouble(),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "name": name,
    "quantity": quantity,
    "price": price,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
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

class UserInfo {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? accountEmail;
  final String? accountPhone;
  final String? accountType;
  final String? brand;
  final String? city;
  final String? company;
  final String? contractComptabilit;
  final String? contractFacturation;
  final String? postCode;
  final String? siret;
  final String? status;
  final DateTime? createAt;
  final DateTime? updateAt;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.password,
    this.accountEmail,
    this.accountPhone,
    this.accountType,
    this.brand,
    this.city,
    this.company,
    this.contractComptabilit,
    this.contractFacturation,
    this.postCode,
    this.siret,
    this.status,
    this.createAt,
    this.updateAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    accountEmail: json["account_email"],
    accountPhone: json["account_phone"],
    accountType: json["account_type"],
    brand: json["brand"],
    city: json["city"],
    company: json["company"],
    contractComptabilit: json["contract_comptabilité"],
    contractFacturation: json["contract_facturation"],
    postCode: json["post_code"],
    siret: json["siret"],
    status: json["status"],
    createAt: json["create_at"] == null ? null : DateTime.parse(json["create_at"]),
    updateAt: json["update_at"] == null ? null : DateTime.parse(json["update_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "account_email": accountEmail,
    "account_phone": accountPhone,
    "account_type": accountType,
    "brand": brand,
    "city": city,
    "company": company,
    "contract_comptabilité": contractComptabilit,
    "contract_facturation": contractFacturation,
    "post_code": postCode,
    "siret": siret,
    "status": status,
    "create_at": createAt?.toIso8601String(),
    "update_at": updateAt?.toIso8601String(),
  };
}
