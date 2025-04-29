// To parse this JSON data, do
//
//     final financialStatusModel = financialStatusModelFromJson(jsonString);

import 'dart:convert';

FinancialStatusModel financialStatusModelFromJson(String str) => FinancialStatusModel.fromJson(json.decode(str));

String financialStatusModelToJson(FinancialStatusModel data) => json.encode(data.toJson());

class FinancialStatusModel {
  String? title;
  FinancialStatus? data;

  FinancialStatusModel({
    this.title,
    this.data,
  });

  FinancialStatusModel copyWith({
    String? title,
    FinancialStatus? data,
  }) =>
      FinancialStatusModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory FinancialStatusModel.fromJson(Map<String, dynamic> json) => FinancialStatusModel(
    title: json["title"],
    data: json["data"] == null ? null : FinancialStatus.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class FinancialStatus {
  int? totalEarning;
  List<WeeklySale>? weeklySales;

  FinancialStatus({
    this.totalEarning,
    this.weeklySales,
  });

  FinancialStatus copyWith({
    int? totalEarning,
    List<WeeklySale>? weeklySales,
  }) =>
      FinancialStatus(
        totalEarning: totalEarning ?? this.totalEarning,
        weeklySales: weeklySales ?? this.weeklySales,
      );

  factory FinancialStatus.fromJson(Map<String, dynamic> json) => FinancialStatus(
    totalEarning: json["total_earning"],
    weeklySales: json["weekly_sales"] == null ? [] : List<WeeklySale>.from(json["weekly_sales"]!.map((x) => WeeklySale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_earning": totalEarning,
    "weekly_sales": weeklySales == null ? [] : List<dynamic>.from(weeklySales!.map((x) => x.toJson())),
  };
}

class WeeklySale {
  String? week;
  DateTime? startDate;
  DateTime? endDate;
  int? totalSales;

  WeeklySale({
    this.week,
    this.startDate,
    this.endDate,
    this.totalSales,
  });

  WeeklySale copyWith({
    String? week,
    DateTime? startDate,
    DateTime? endDate,
    int? totalSales,
  }) =>
      WeeklySale(
        week: week ?? this.week,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        totalSales: totalSales ?? this.totalSales,
      );

  factory WeeklySale.fromJson(Map<String, dynamic> json) => WeeklySale(
    week: json["week"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalSales: json["total_sales"],
  );

  Map<String, dynamic> toJson() => {
    "week": week,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "total_sales": totalSales,
  };
}
