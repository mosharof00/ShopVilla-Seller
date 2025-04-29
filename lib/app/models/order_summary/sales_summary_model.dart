// To parse this JSON data, do
//
//     final salesSummaryModel = salesSummaryModelFromJson(jsonString);

import 'dart:convert';

SalesSummaryModel salesSummaryModelFromJson(String str) => SalesSummaryModel.fromJson(json.decode(str));

String salesSummaryModelToJson(SalesSummaryModel data) => json.encode(data.toJson());

class SalesSummaryModel {
  String? title;
  SalesSummaryData? data;

  SalesSummaryModel({
    this.title,
    this.data,
  });

  SalesSummaryModel copyWith({
    String? title,
    SalesSummaryData? data,
  }) =>
      SalesSummaryModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory SalesSummaryModel.fromJson(Map<String, dynamic> json) => SalesSummaryModel(
    title: json["title"],
    data: json["data"] == null ? null : SalesSummaryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class SalesSummaryData {
  int? totalOrderPrice;
  int? totalOrder;
  int? totalPendingOrder;
  List<MonthlySale>? monthlySales;

  SalesSummaryData({
    this.totalOrderPrice,
    this.totalOrder,
    this.totalPendingOrder,
    this.monthlySales,
  });

  SalesSummaryData copyWith({
    int? totalOrderPrice,
    int? totalOrder,
    int? totalPendingOrder,
    List<MonthlySale>? monthlySales,
  }) =>
      SalesSummaryData(
        totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
        totalOrder: totalOrder ?? this.totalOrder,
        totalPendingOrder: totalPendingOrder ?? this.totalPendingOrder,
        monthlySales: monthlySales ?? this.monthlySales,
      );

  factory SalesSummaryData.fromJson(Map<String, dynamic> json) => SalesSummaryData(
    totalOrderPrice: json["total_order_price"],
    totalOrder: json["total_order"],
    totalPendingOrder: json["total_pending_order"],
    monthlySales: json["monthly_sales"] == null ? [] : List<MonthlySale>.from(json["monthly_sales"]!.map((x) => MonthlySale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_order_price": totalOrderPrice,
    "total_order": totalOrder,
    "total_pending_order": totalPendingOrder,
    "monthly_sales": monthlySales == null ? [] : List<dynamic>.from(monthlySales!.map((x) => x.toJson())),
  };
}

class MonthlySale {
  String? year;
  String? month;
  int? totalSales;

  MonthlySale({
    this.year,
    this.month,
    this.totalSales,
  });

  MonthlySale copyWith({
    String? year,
    String? month,
    int? totalSales,
  }) =>
      MonthlySale(
        year: year ?? this.year,
        month: month ?? this.month,
        totalSales: totalSales ?? this.totalSales,
      );

  factory MonthlySale.fromJson(Map<String, dynamic> json) => MonthlySale(
    year: json["year"],
    month: json["month"],
    totalSales: json["total_sales"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "total_sales": totalSales,
  };
}
