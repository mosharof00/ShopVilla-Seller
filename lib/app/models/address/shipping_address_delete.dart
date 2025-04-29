import 'dart:convert';

ShippingAddressDeleteModel shippingAddressDeleteModelFromJson(String str) => ShippingAddressDeleteModel.fromJson(json.decode(str));

String shippingAddressDeleteModelToJson(ShippingAddressDeleteModel data) => json.encode(data.toJson());

class ShippingAddressDeleteModel {
  bool? status;
  String? message;
  dynamic data;

  ShippingAddressDeleteModel({
    this.status,
    this.message,
    this.data,
  });

  ShippingAddressDeleteModel copyWith({
    bool? status,
    String? message,
    dynamic data,
  }) =>
      ShippingAddressDeleteModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShippingAddressDeleteModel.fromJson(Map<String, dynamic> json) => ShippingAddressDeleteModel(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
