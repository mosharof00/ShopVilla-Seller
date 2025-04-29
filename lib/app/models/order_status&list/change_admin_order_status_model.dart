// To parse this JSON data, do
//
//     final changeAdminOrderStatusModel = changeAdminOrderStatusModelFromJson(jsonString);

import 'dart:convert';

ChangeAdminOrderStatusModel changeAdminOrderStatusModelFromJson(String str) =>
    ChangeAdminOrderStatusModel.fromJson(json.decode(str));

String changeAdminOrderStatusModelToJson(ChangeAdminOrderStatusModel data) =>
    json.encode(data.toJson());

class ChangeAdminOrderStatusModel {
  String? title;
  ChangeAdminOrderStatusData? data;

  ChangeAdminOrderStatusModel({
    this.title,
    this.data,
  });

  ChangeAdminOrderStatusModel copyWith({
    String? title,
    ChangeAdminOrderStatusData? data,
  }) =>
      ChangeAdminOrderStatusModel(
        title: title ?? this.title,
        data: data ?? this.data,
      );

  factory ChangeAdminOrderStatusModel.fromJson(Map<String, dynamic> json) =>
      ChangeAdminOrderStatusModel(
        title: json["title"],
        data: json["data"] == null
            ? null
            : ChangeAdminOrderStatusData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "data": data?.toJson(),
      };
}

class ChangeAdminOrderStatusData {
  int? id;
  String? invoiceId;
  int? webId;
  int? userId;
  dynamic note;
  dynamic courierId;
  dynamic cityId;
  dynamic zoneId;
  dynamic areaId;
  int? subTotal;
  int? shippingCharge;
  int? discount;
  int? total;
  int? vat;
  int? tax;
  dynamic coupon;
  int? paidAmount;
  DateTime? orderDate;
  dynamic confirmDate;
  dynamic shippingDate;
  dynamic deliveryDate;
  String? status;
  int? adminId;
  dynamic sellerId;
  dynamic paymentId;
  String? name;
  String? email;
  String? phone;
  String? address;
  dynamic country;
  String? city;
  String? district;
  dynamic state;
  dynamic zipCode;
  dynamic orderNote;
  dynamic amount;
  dynamic transactionId;
  dynamic currency;
  DateTime? createdAt;
  DateTime? updatedAt;

  ChangeAdminOrderStatusData({
    this.id,
    this.invoiceId,
    this.webId,
    this.userId,
    this.note,
    this.courierId,
    this.cityId,
    this.zoneId,
    this.areaId,
    this.subTotal,
    this.shippingCharge,
    this.discount,
    this.total,
    this.vat,
    this.tax,
    this.coupon,
    this.paidAmount,
    this.orderDate,
    this.confirmDate,
    this.shippingDate,
    this.deliveryDate,
    this.status,
    this.adminId,
    this.sellerId,
    this.paymentId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.country,
    this.city,
    this.district,
    this.state,
    this.zipCode,
    this.orderNote,
    this.amount,
    this.transactionId,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  ChangeAdminOrderStatusData copyWith({
    int? id,
    String? invoiceId,
    int? webId,
    int? userId,
    dynamic note,
    dynamic courierId,
    dynamic cityId,
    dynamic zoneId,
    dynamic areaId,
    int? subTotal,
    int? shippingCharge,
    int? discount,
    int? total,
    int? vat,
    int? tax,
    dynamic coupon,
    int? paidAmount,
    DateTime? orderDate,
    dynamic confirmDate,
    dynamic shippingDate,
    dynamic deliveryDate,
    String? status,
    int? adminId,
    dynamic sellerId,
    dynamic paymentId,
    String? name,
    String? email,
    String? phone,
    String? address,
    dynamic country,
    String? city,
    String? district,
    dynamic state,
    dynamic zipCode,
    dynamic orderNote,
    dynamic amount,
    dynamic transactionId,
    dynamic currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChangeAdminOrderStatusData(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        webId: webId ?? this.webId,
        userId: userId ?? this.userId,
        note: note ?? this.note,
        courierId: courierId ?? this.courierId,
        cityId: cityId ?? this.cityId,
        zoneId: zoneId ?? this.zoneId,
        areaId: areaId ?? this.areaId,
        subTotal: subTotal ?? this.subTotal,
        shippingCharge: shippingCharge ?? this.shippingCharge,
        discount: discount ?? this.discount,
        total: total ?? this.total,
        vat: vat ?? this.vat,
        tax: tax ?? this.tax,
        coupon: coupon ?? this.coupon,
        paidAmount: paidAmount ?? this.paidAmount,
        orderDate: orderDate ?? this.orderDate,
        confirmDate: confirmDate ?? this.confirmDate,
        shippingDate: shippingDate ?? this.shippingDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        status: status ?? this.status,
        adminId: adminId ?? this.adminId,
        sellerId: sellerId ?? this.sellerId,
        paymentId: paymentId ?? this.paymentId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        country: country ?? this.country,
        city: city ?? this.city,
        district: district ?? this.district,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        orderNote: orderNote ?? this.orderNote,
        amount: amount ?? this.amount,
        transactionId: transactionId ?? this.transactionId,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChangeAdminOrderStatusData.fromJson(Map<String, dynamic> json) =>
      ChangeAdminOrderStatusData(
        id: json["id"],
        invoiceId: json["invoiceID"],
        webId: json["web_id"],
        userId: json["user_id"],
        note: json["note"],
        courierId: json["courier_id"],
        cityId: json["city_id"],
        zoneId: json["zone_id"],
        areaId: json["area_id"],
        subTotal: json["subTotal"],
        shippingCharge: json["shippingCharge"],
        discount: json["discount"],
        total: json["total"],
        vat: json["vat"],
        tax: json["tax"],
        coupon: json["coupon"],
        paidAmount: json["paidAmount"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        confirmDate: json["confirmDate"],
        shippingDate: json["shippingDate"],
        deliveryDate: json["deliveryDate"],
        status: json["status"],
        adminId: json["admin_id"],
        sellerId: json["seller_id"],
        paymentId: json["payment_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        zipCode: json["zip_code"],
        orderNote: json["order_note"],
        amount: json["amount"],
        transactionId: json["transaction_id"],
        currency: json["currency"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceID": invoiceId,
        "web_id": webId,
        "user_id": userId,
        "note": note,
        "courier_id": courierId,
        "city_id": cityId,
        "zone_id": zoneId,
        "area_id": areaId,
        "subTotal": subTotal,
        "shippingCharge": shippingCharge,
        "discount": discount,
        "total": total,
        "vat": vat,
        "tax": tax,
        "coupon": coupon,
        "paidAmount": paidAmount,
        "orderDate":
            "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "confirmDate": confirmDate,
        "shippingDate": shippingDate,
        "deliveryDate": deliveryDate,
        "status": status,
        "admin_id": adminId,
        "seller_id": sellerId,
        "payment_id": paymentId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "country": country,
        "city": city,
        "district": district,
        "state": state,
        "zip_code": zipCode,
        "order_note": orderNote,
        "amount": amount,
        "transaction_id": transactionId,
        "currency": currency,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
