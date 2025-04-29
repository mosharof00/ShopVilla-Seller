// To parse this JSON data, do
//
//     final cancelOrderModel = cancelOrderModelFromJson(jsonString);

import 'dart:convert';

CancelOrderModel cancelOrderModelFromJson(String str) =>
    CancelOrderModel.fromJson(json.decode(str));

String cancelOrderModelToJson(CancelOrderModel data) =>
    json.encode(data.toJson());

class CancelOrderModel {
  bool? status;
  String? message;

  CancelOrderModel({
    this.status,
    this.message,
  });

  CancelOrderModel copyWith({
    bool? status,
    String? message,
  }) =>
      CancelOrderModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
