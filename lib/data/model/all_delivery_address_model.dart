// To parse this JSON data, do
//
//     final allDeliveryAddressByIdModel = allDeliveryAddressByIdModelFromJson(jsonString);

import 'dart:convert';

AllDeliveryAddressByIdModel allDeliveryAddressByIdModelFromJson(String str) => AllDeliveryAddressByIdModel.fromJson(json.decode(str));

String allDeliveryAddressByIdModelToJson(AllDeliveryAddressByIdModel data) => json.encode(data.toJson());

class AllDeliveryAddressByIdModel {
  final bool? success;
  final String? message;
  final List<DeliveryAddressModel>? data;

  AllDeliveryAddressByIdModel({
    this.success,
    this.message,
    this.data,
  });

  factory AllDeliveryAddressByIdModel.fromJson(Map<String, dynamic> json) => AllDeliveryAddressByIdModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DeliveryAddressModel>.from(json["data"]!.map((x) => DeliveryAddressModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DeliveryAddressModel {
  final int? id;
  final int? userId;
  final String? phone;
  final String? contact;
  final String? address;
  final String? addressType;
  final String? city;
  final String? postCode;
  final String? message;

  DeliveryAddressModel({
    this.id,
    this.userId,
    this.phone,
    this.contact,
    this.address,
    this.addressType,
    this.city,
    this.postCode,
    this.message,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) => DeliveryAddressModel(
    id: json["id"],
    userId: json["user_id"],
    phone: json["phone"],
    contact: json["contact"],
    address: json["address"],
    addressType: json["address_type"],
    city: json["city"],
    postCode: json["post_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "phone": phone,
    "contact": contact,
    "address": address,
    "address_type": addressType,
    "city": city,
    "post_code": postCode,
    "message": message,
  };
}
