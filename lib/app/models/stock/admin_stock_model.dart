// To parse this JSON data, do
//
//     final adminStockModel = adminStockModelFromJson(jsonString);

import 'dart:convert';

AdminStockModel adminStockModelFromJson(String str) => AdminStockModel.fromJson(json.decode(str));

String adminStockModelToJson(AdminStockModel data) => json.encode(data.toJson());

class AdminStockModel {
  String? title;
  AdminStock? data;

  AdminStockModel({
    this.title,
    this.data,
  });

  AdminStockModel copyWith({
    String? title,
    AdminStock? data,
  }) =>
      AdminStockModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory AdminStockModel.fromJson(Map<String, dynamic> json) => AdminStockModel(
    title: json["title"],
    data: json["data"] == null ? null : AdminStock.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class AdminStock {
  int? totalProductStock;
  int? recentlyAddedProduct;
  int? sold;

  AdminStock({
    this.totalProductStock,
    this.recentlyAddedProduct,
    this.sold,
  });

  AdminStock copyWith({
    int? totalProductStock,
    int? recentlyAddedProduct,
    int? sold,
  }) =>
      AdminStock(
        totalProductStock: totalProductStock ?? this.totalProductStock,
        recentlyAddedProduct: recentlyAddedProduct ?? this.recentlyAddedProduct,
        sold: sold ?? this.sold,
      );

  factory AdminStock.fromJson(Map<String, dynamic> json) => AdminStock(
    totalProductStock: json["total_product_stock"],
    recentlyAddedProduct: json["recently_added_product"],
    sold: json["sold"],
  );

  Map<String, dynamic> toJson() => {
    "total_product_stock": totalProductStock,
    "recently_added_product": recentlyAddedProduct,
    "sold": sold,
  };
}
