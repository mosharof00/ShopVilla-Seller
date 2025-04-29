// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) =>
    AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) =>
    json.encode(data.toJson());

class AddProductModel {
  bool? status;
  String? message;
  AddProductData? data;

  AddProductModel({
    this.status,
    this.message,
    this.data,
  });

  AddProductModel copyWith({
    bool? status,
    String? message,
    AddProductData? data,
  }) =>
      AddProductModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddProductModel.fromJson(Map<String, dynamic> json) =>
      AddProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AddProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AddProductData {
  String? productName;
  String? productSku;
  int? categoryId;
  int? subCategoryId;
  dynamic brandId;
  dynamic childCategoryId;
  String? productDescription;
  dynamic youtubeEmbadecode;
  dynamic gander;
  dynamic shippingType;
  dynamic shippigCost;
  dynamic shippingRtnPolicy;
  dynamic offerStart;
  dynamic offerEnd;
  int? discountPercent;
  dynamic multipleQty;
  dynamic metaName;
  dynamic metaTitle;
  dynamic metaKeywords;
  dynamic metaDescription;
  int? supplierId;
  dynamic advancePaymentAmount;
  String? type;
  String? status;
  String? slug;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  AddProductData({
    this.productName,
    this.productSku,
    this.categoryId,
    this.subCategoryId,
    this.brandId,
    this.childCategoryId,
    this.productDescription,
    this.youtubeEmbadecode,
    this.gander,
    this.shippingType,
    this.shippigCost,
    this.shippingRtnPolicy,
    this.offerStart,
    this.offerEnd,
    this.discountPercent,
    this.multipleQty,
    this.metaName,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.supplierId,
    this.advancePaymentAmount,
    this.type,
    this.status,
    this.slug,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  AddProductData copyWith({
    String? productName,
    String? productSku,
    int? categoryId,
    int? subCategoryId,
    dynamic brandId,
    dynamic childCategoryId,
    String? productDescription,
    dynamic youtubeEmbadecode,
    dynamic gander,
    dynamic shippingType,
    dynamic shippigCost,
    dynamic shippingRtnPolicy,
    dynamic offerStart,
    dynamic offerEnd,
    int? discountPercent,
    dynamic multipleQty,
    dynamic metaName,
    dynamic metaTitle,
    dynamic metaKeywords,
    dynamic metaDescription,
    int? supplierId,
    dynamic advancePaymentAmount,
    String? type,
    String? status,
    String? slug,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      AddProductData(
        productName: productName ?? this.productName,
        productSku: productSku ?? this.productSku,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        brandId: brandId ?? this.brandId,
        childCategoryId: childCategoryId ?? this.childCategoryId,
        productDescription: productDescription ?? this.productDescription,
        youtubeEmbadecode: youtubeEmbadecode ?? this.youtubeEmbadecode,
        gander: gander ?? this.gander,
        shippingType: shippingType ?? this.shippingType,
        shippigCost: shippigCost ?? this.shippigCost,
        shippingRtnPolicy: shippingRtnPolicy ?? this.shippingRtnPolicy,
        offerStart: offerStart ?? this.offerStart,
        offerEnd: offerEnd ?? this.offerEnd,
        discountPercent: discountPercent ?? this.discountPercent,
        multipleQty: multipleQty ?? this.multipleQty,
        metaName: metaName ?? this.metaName,
        metaTitle: metaTitle ?? this.metaTitle,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        supplierId: supplierId ?? this.supplierId,
        advancePaymentAmount: advancePaymentAmount ?? this.advancePaymentAmount,
        type: type ?? this.type,
        status: status ?? this.status,
        slug: slug ?? this.slug,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory AddProductData.fromJson(Map<String, dynamic> json) => AddProductData(
        productName: json["product_name"],
        productSku: json["product_sku"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        brandId: json["brand_id"],
        childCategoryId: json["child_category_id"],
        productDescription: json["product_description"],
        youtubeEmbadecode: json["youtube_embadecode"],
        gander: json["gander"],
        shippingType: json["shipping_type"],
        shippigCost: json["shippig_cost"],
        shippingRtnPolicy: json["shipping_rtn_policy"],
        offerStart: json["offer_start"],
        offerEnd: json["offer_end"],
        discountPercent: json["discount_percent"],
        multipleQty: json["multiple_qty"],
        metaName: json["meta_name"],
        metaTitle: json["meta_title"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        supplierId: json["supplier_id"],
        advancePaymentAmount: json["advance_payment_amount"],
        type: json["type"],
        status: json["status"],
        slug: json["slug"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_sku": productSku,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "brand_id": brandId,
        "child_category_id": childCategoryId,
        "product_description": productDescription,
        "youtube_embadecode": youtubeEmbadecode,
        "gander": gander,
        "shipping_type": shippingType,
        "shippig_cost": shippigCost,
        "shipping_rtn_policy": shippingRtnPolicy,
        "offer_start": offerStart,
        "offer_end": offerEnd,
        "discount_percent": discountPercent,
        "multiple_qty": multipleQty,
        "meta_name": metaName,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "supplier_id": supplierId,
        "advance_payment_amount": advancePaymentAmount,
        "type": type,
        "status": status,
        "slug": slug,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
