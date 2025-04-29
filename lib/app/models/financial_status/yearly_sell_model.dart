// To parse this JSON data, do
//
//     final yearlySellModel = yearlySellModelFromJson(jsonString);

import 'dart:convert';

YearlySellModel yearlySellModelFromJson(String str) => YearlySellModel.fromJson(json.decode(str));

String yearlySellModelToJson(YearlySellModel data) => json.encode(data.toJson());

class YearlySellModel {
  bool? status;
  String? message;
  List<YearlySell>? data;

  YearlySellModel({
    this.status,
    this.message,
    this.data,
  });

  YearlySellModel copyWith({
    bool? status,
    String? message,
    List<YearlySell>? data,
  }) =>
      YearlySellModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory YearlySellModel.fromJson(Map<String, dynamic> json) => YearlySellModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<YearlySell>.from(json["data"]!.map((x) => YearlySell.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class YearlySell {
  String? year;
  String? month;
  int? amount;
  num? percent;

  YearlySell({
    this.year,
    this.month,
    this.amount,
    this.percent,
  });

  YearlySell copyWith({
    String? year,
    String? month,
    int? amount,
    num? percent,
  }) =>
      YearlySell(
        year: year ?? this.year,
        month: month ?? this.month,
        amount: amount ?? this.amount,
        percent: percent ?? this.percent,
      );

  factory YearlySell.fromJson(Map<String, dynamic> json) => YearlySell(
    year: json["year"],
    month: json["month"],
    amount: json["amount"],
    percent: json["percent"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "amount": amount,
    "percent": percent,
  };
}
