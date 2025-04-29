// To parse this JSON data, do
//
//     final addProductVariationModel = addProductVariationModelFromJson(jsonString);

import 'dart:convert';

AddProductVariationModel addProductVariationModelFromJson(String str) =>
    AddProductVariationModel.fromJson(json.decode(str));

String addProductVariationModelToJson(AddProductVariationModel data) =>
    json.encode(data.toJson());

class AddProductVariationModel {
  bool? status;
  String? message;
  Data? data;

  AddProductVariationModel({
    this.status,
    this.message,
    this.data,
  });

  AddProductVariationModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      AddProductVariationModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory AddProductVariationModel.fromJson(Map<String, dynamic> json) =>
      AddProductVariationModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Variation? variation;
  VariationImage? variationImage;
  AddVariationProduct? product;

  Data({
    this.variation,
    this.variationImage,
    this.product,
  });

  Data copyWith({
    Variation? variation,
    VariationImage? variationImage,
    AddVariationProduct? product,
  }) =>
      Data(
        variation: variation ?? this.variation,
        variationImage: variationImage ?? this.variationImage,
        product: product ?? this.product,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        variation: json["variation"] == null
            ? null
            : Variation.fromJson(json["variation"]),
        variationImage: json["variationImage"] == null
            ? null
            : VariationImage.fromJson(json["variationImage"]),
        product:
            json["product"] == null ? null : AddVariationProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "variation": variation?.toJson(),
        "variationImage": variationImage?.toJson(),
        "product": product?.toJson(),
      };
}

class AddVariationProduct {
  int? id;
  String? productName;
  String? slug;
  String? productSku;
  int? categoryId;
  int? subCategoryId;
  dynamic childCategoryId;
  dynamic brandId;
  String? productDescription;
  dynamic gander;
  dynamic youtubeEmbadecode;
  String? type;
  dynamic shippingType;
  dynamic shippigCost;
  dynamic shippingRtnPolicy;
  dynamic offerStart;
  dynamic offerEnd;
  int? discountPercent;
  dynamic multipleQty;
  dynamic collectionId;
  dynamic collectionName;
  dynamic metaName;
  dynamic metaTitle;
  dynamic metaImage;
  dynamic metaKeywords;
  dynamic metaDescription;
  int? totalStock;
  int? available;
  int? sold;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddVariationProduct({
    this.id,
    this.productName,
    this.slug,
    this.productSku,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.productDescription,
    this.gander,
    this.youtubeEmbadecode,
    this.type,
    this.shippingType,
    this.shippigCost,
    this.shippingRtnPolicy,
    this.offerStart,
    this.offerEnd,
    this.discountPercent,
    this.multipleQty,
    this.collectionId,
    this.collectionName,
    this.metaName,
    this.metaTitle,
    this.metaImage,
    this.metaKeywords,
    this.metaDescription,
    this.totalStock,
    this.available,
    this.sold,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  AddVariationProduct copyWith({
    int? id,
    String? productName,
    String? slug,
    String? productSku,
    int? categoryId,
    int? subCategoryId,
    dynamic childCategoryId,
    dynamic brandId,
    String? productDescription,
    dynamic gander,
    dynamic youtubeEmbadecode,
    String? type,
    dynamic shippingType,
    dynamic shippigCost,
    dynamic shippingRtnPolicy,
    dynamic offerStart,
    dynamic offerEnd,
    int? discountPercent,
    dynamic multipleQty,
    dynamic collectionId,
    dynamic collectionName,
    dynamic metaName,
    dynamic metaTitle,
    dynamic metaImage,
    dynamic metaKeywords,
    dynamic metaDescription,
    int? totalStock,
    int? available,
    int? sold,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AddVariationProduct(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        slug: slug ?? this.slug,
        productSku: productSku ?? this.productSku,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        childCategoryId: childCategoryId ?? this.childCategoryId,
        brandId: brandId ?? this.brandId,
        productDescription: productDescription ?? this.productDescription,
        gander: gander ?? this.gander,
        youtubeEmbadecode: youtubeEmbadecode ?? this.youtubeEmbadecode,
        type: type ?? this.type,
        shippingType: shippingType ?? this.shippingType,
        shippigCost: shippigCost ?? this.shippigCost,
        shippingRtnPolicy: shippingRtnPolicy ?? this.shippingRtnPolicy,
        offerStart: offerStart ?? this.offerStart,
        offerEnd: offerEnd ?? this.offerEnd,
        discountPercent: discountPercent ?? this.discountPercent,
        multipleQty: multipleQty ?? this.multipleQty,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        metaName: metaName ?? this.metaName,
        metaTitle: metaTitle ?? this.metaTitle,
        metaImage: metaImage ?? this.metaImage,
        metaKeywords: metaKeywords ?? this.metaKeywords,
        metaDescription: metaDescription ?? this.metaDescription,
        totalStock: totalStock ?? this.totalStock,
        available: available ?? this.available,
        sold: sold ?? this.sold,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AddVariationProduct.fromJson(Map<String, dynamic> json) => AddVariationProduct(
        id: json["id"],
        productName: json["product_name"],
        slug: json["slug"],
        productSku: json["product_sku"],
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        childCategoryId: json["child_category_id"],
        brandId: json["brand_id"],
        productDescription: json["product_description"],
        gander: json["gander"],
        youtubeEmbadecode: json["youtube_embadecode"],
        type: json["type"],
        shippingType: json["shipping_type"],
        shippigCost: json["shippig_cost"],
        shippingRtnPolicy: json["shipping_rtn_policy"],
        offerStart: json["offer_start"],
        offerEnd: json["offer_end"],
        discountPercent: json["discount_percent"],
        multipleQty: json["multiple_qty"],
        collectionId: json["collection_id"],
        collectionName: json["collection_name"],
        metaName: json["meta_name"],
        metaTitle: json["meta_title"],
        metaImage: json["meta_image"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        totalStock: json["total_stock"],
        available: json["available"],
        sold: json["sold"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "slug": slug,
        "product_sku": productSku,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "child_category_id": childCategoryId,
        "brand_id": brandId,
        "product_description": productDescription,
        "gander": gander,
        "youtube_embadecode": youtubeEmbadecode,
        "type": type,
        "shipping_type": shippingType,
        "shippig_cost": shippigCost,
        "shipping_rtn_policy": shippingRtnPolicy,
        "offer_start": offerStart,
        "offer_end": offerEnd,
        "discount_percent": discountPercent,
        "multiple_qty": multipleQty,
        "collection_id": collectionId,
        "collection_name": collectionName,
        "meta_name": metaName,
        "meta_title": metaTitle,
        "meta_image": metaImage,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "total_stock": totalStock,
        "available": available,
        "sold": sold,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Variation {
  int? productId;
  int? colorId;
  String? color;
  String? colorCode;
  String? image;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Variation({
    this.productId,
    this.colorId,
    this.color,
    this.colorCode,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Variation copyWith({
    int? productId,
    int? colorId,
    String? color,
    String? colorCode,
    String? image,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Variation(
        productId: productId ?? this.productId,
        colorId: colorId ?? this.colorId,
        color: color ?? this.color,
        colorCode: colorCode ?? this.colorCode,
        image: image ?? this.image,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        productId: json["product_id"],
        colorId: json["color_id"],
        color: json["color"],
        colorCode: json["color_code"],
        image: json["image"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "color_id": colorId,
        "color": color,
        "color_code": colorCode,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class VariationImage {
  int? variationId;
  String? imagePath;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  VariationImage({
    this.variationId,
    this.imagePath,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  VariationImage copyWith({
    int? variationId,
    String? imagePath,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      VariationImage(
        variationId: variationId ?? this.variationId,
        imagePath: imagePath ?? this.imagePath,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory VariationImage.fromJson(Map<String, dynamic> json) => VariationImage(
        variationId: json["variation_id"],
        imagePath: json["image_path"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "variation_id": variationId,
        "image_path": imagePath,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
