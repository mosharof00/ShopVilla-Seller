// To parse this JSON data, do
//
//     final orderSummaryModel = orderSummaryModelFromJson(jsonString);

import 'dart:convert';

OrderSummaryModel orderSummaryModelFromJson(String str) => OrderSummaryModel.fromJson(json.decode(str));

String orderSummaryModelToJson(OrderSummaryModel data) => json.encode(data.toJson());

class OrderSummaryModel {
  bool? status;
  String? message;
  OrderSummary? data;

  OrderSummaryModel({
    this.status,
    this.message,
    this.data,
  });

  OrderSummaryModel copyWith({
    bool? status,
    String? message,
    OrderSummary? data,
  }) =>
      OrderSummaryModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) => OrderSummaryModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OrderSummary.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OrderSummary {
  int? totalOrderCount;
  int? totalOrderAmount;
  List<YearlySale>? yearlySale;

  OrderSummary({
    this.totalOrderCount,
    this.totalOrderAmount,
    this.yearlySale,
  });

  OrderSummary copyWith({
    int? totalOrderCount,
    int? totalOrderAmount,
    List<YearlySale>? yearlySale,
  }) =>
      OrderSummary(
        totalOrderCount: totalOrderCount ?? this.totalOrderCount,
        totalOrderAmount: totalOrderAmount ?? this.totalOrderAmount,
        yearlySale: yearlySale ?? this.yearlySale,
      );

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
    totalOrderCount: json["total_order_count"],
    totalOrderAmount: json["total_order_amount"],
    yearlySale: json["yearly_sall"] == null ? [] : List<YearlySale>.from(json["yearly_sall"]!.map((x) => YearlySale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_order_count": totalOrderCount,
    "total_order_amount": totalOrderAmount,
    "yearly_sall": yearlySale == null ? [] : List<dynamic>.from(yearlySale!.map((x) => x.toJson())),
  };
}

class YearlySale {
  String? year;
  String? month;
  int? totalAmount;
  int? totalCount;

  YearlySale({
    this.year,
    this.month,
    this.totalAmount,
    this.totalCount,
  });

  YearlySale copyWith({
    String? year,
    String? month,
    int? totalAmount,
    int? totalCount,
  }) =>
      YearlySale(
        year: year ?? this.year,
        month: month ?? this.month,
        totalAmount: totalAmount ?? this.totalAmount,
        totalCount: totalCount ?? this.totalCount,
      );

  factory YearlySale.fromJson(Map<String, dynamic> json) => YearlySale(
    year: json["year"],
    month: json["month"],
    totalAmount: json["total_amount"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "total_amount": totalAmount,
    "total_count": totalCount,
  };
}
