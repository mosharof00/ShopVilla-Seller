// To parse this JSON data, do
//
//     final adminOrderSearch = adminOrderSearchFromJson(jsonString);

import 'dart:convert';

TotalWeeklyOrder adminOrderSearchFromJson(String str) => TotalWeeklyOrder.fromJson(json.decode(str));

String adminOrderSearchToJson(TotalWeeklyOrder data) => json.encode(data.toJson());

class TotalWeeklyOrder {
  String? title;
  WeeklyOrder? data;

  TotalWeeklyOrder({
    this.title,
    this.data,
  });

  TotalWeeklyOrder copyWith({
    String? title,
    WeeklyOrder? data,
  }) =>
      TotalWeeklyOrder(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory TotalWeeklyOrder.fromJson(Map<String, dynamic> json) => TotalWeeklyOrder(
    title: json["title"],
    data: json["data"] == null ? null : WeeklyOrder.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "data": data?.toJson(),
  };
}

class WeeklyOrder {
  int? totalOrderPrice;
  int? totalPendingOrder;
  int? totalActiveOrder;
  int? todayTotalSale;
  List<DailyOrder>? dailyOrders;

  WeeklyOrder({
    this.totalOrderPrice,
    this.totalPendingOrder,
    this.totalActiveOrder,
    this.todayTotalSale,
    this.dailyOrders,
  });

  WeeklyOrder copyWith({
    int? totalOrderPrice,
    int? totalPendingOrder,
    int? totalActiveOrder,
    int? todayTotalSale,
    List<DailyOrder>? dailyOrders,
  }) =>
      WeeklyOrder(
        totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
        totalPendingOrder: totalPendingOrder ?? this.totalPendingOrder,
        totalActiveOrder: totalActiveOrder ?? this.totalActiveOrder,
        todayTotalSale: todayTotalSale ?? this.todayTotalSale,
        dailyOrders: dailyOrders ?? this.dailyOrders,
      );

  factory WeeklyOrder.fromJson(Map<String, dynamic> json) => WeeklyOrder(
    totalOrderPrice: json["total_order_price"],
    totalPendingOrder: json["total_pending_order"],
    totalActiveOrder: json["total_active_order"],
    todayTotalSale: json["today_total_sale"],
    dailyOrders: json["dailyOrders"] == null ? [] : List<DailyOrder>.from(json["dailyOrders"]!.map((x) => DailyOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_order_price": totalOrderPrice,
    "total_pending_order": totalPendingOrder,
    "total_active_order": totalActiveOrder,
    "today_total_sale": todayTotalSale,
    "dailyOrders": dailyOrders == null ? [] : List<dynamic>.from(dailyOrders!.map((x) => x.toJson())),
  };
}

class DailyOrder {
  DateTime? date;
  int? count;

  DailyOrder({
    this.date,
    this.count,
  });

  DailyOrder copyWith({
    DateTime? date,
    int? count,
  }) =>
      DailyOrder(
        date: date ?? this.date,
        count: count ?? this.count,
      );

  factory DailyOrder.fromJson(Map<String, dynamic> json) => DailyOrder(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "count": count,
  };
}