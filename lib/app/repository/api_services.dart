import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_villa_seller/app/models/Customers/customers_get_model.dart';
import 'package:shop_villa_seller/app/models/category/Category_Model/category_update_model.dart';
import 'package:shop_villa_seller/app/models/category/sub_category/sub_category_post_model.dart';
import 'package:shop_villa_seller/app/models/currency/currency.dart';
import 'package:shop_villa_seller/app/models/financial_status/financial_status_model.dart';
import 'package:shop_villa_seller/app/models/financial_status/yearly_sell_model.dart';
import 'package:shop_villa_seller/app/models/order%20place/re_order_model.dart';
import 'package:shop_villa_seller/app/models/product_model/add_product_variation_model.dart';
import 'package:shop_villa_seller/app/models/product_model/product_variation_list_model.dart';
import 'package:shop_villa_seller/app/models/product_model/sort_filter__list_model.dart';
import 'package:shop_villa_seller/app/models/q&a/q&aPostModel.dart';
import 'package:shop_villa_seller/app/models/stock/admin_stock_model.dart';
import 'package:shop_villa_seller/app/models/supplier/supplier_delete_model.dart';
import 'package:shop_villa_seller/app/models/supplier/supplier_get_model.dart';
import 'package:shop_villa_seller/app/models/supplier/supplier_post_model.dart';
import 'package:shop_villa_seller/app/models/supplier/supplier_update_model.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import '../../global/log_printer.dart';
import '../models/Delivery Charge/checklist_get_model.dart';
import '../models/Reviews/review_add_model.dart';
import '../models/Reviews/review_get_model.dart';
import '../models/add_product_model/add_product_model.dart';
import '../models/add_product_model/product_attribute_model.dart';
import '../models/address/shipping_address_delete.dart';
import '../models/address/shipping_address_get_model.dart';
import '../models/address/shipping_address_post_model.dart';
import '../models/address/shipping_address_update.dart';
import '../models/auth/log_out_model.dart';
import '../models/auth/login_model.dart';
import '../models/brand/add_brand_model.dart';
import '../models/brand/brand_model.dart';
import '../models/brand/updaet_brand_model.dart';
import '../models/cart/cart_get_model.dart';
import '../models/cart/cart_item_remove_get_model.dart';
import '../models/cart/cart_post_model.dart';
import '../models/cart/cart_update_model.dart';
import '../models/category/Category_Model/category_add_model.dart';
import '../models/category/Category_Model/category_model.dart';
import '../models/category/sub_category/sub_category_model.dart';
import '../models/category/sub_category/sub_category_update_model.dart';
import '../models/coupon/coupon_get_model.dart';
import '../models/coupon/coupon_post_model.dart';
import '../models/courier/courier_get_model.dart';
import '../models/dashboard/dashboard_count.dart';
import '../models/delivery list/delivery_list_model.dart';
import '../models/delivery_options/get_delivery_options.dart';
import '../models/forgot_password_model/forgot_password_model.dart';
import '../models/notification_model/notification_model.dart';
import '../models/order place/order_list_post_model.dart';
import '../models/order place/user_orderlist_post_model.dart';
import '../models/financial_status/order_by_category_model.dart';
import '../models/order_status&list/admin_order_list.dart';
import '../models/order_status&list/all_order_status_count.dart';
import '../models/order_status&list/cancel_order_model.dart';
import '../models/order_status&list/change_admin_order_status_model.dart';
import '../models/order_summary/all_order_status_model.dart';
import '../models/order_summary/order_statistics.dart';
import '../models/order_summary/sales_summary_model.dart';
import '../models/payment_method/payment_method.dart';
import '../models/product_details/product_details_model.dart';
import '../models/product_model/porduct_model_api.dart';
import '../models/product_model/update_product_variation_model.dart';
import '../models/product_model/update_product_variation_model.dart';
import '../models/profile_model/profile_get_model.dart';
import '../models/profile_model/profile_post_model.dart';
import '../models/q&a/q&aGetModel.dart';
import '../models/weekly_order_model/weekly_order_model.dart';
import 'api_endpoint.dart';
import 'authInterceptor.dart';

abstract class IApiService {
  /// Auth
  /// Login:
  Future<LoginModel> loginUser(String email, String password);

  /// LogOut:
  Future<LogOutModel> logOutUser();

  /// ForgotPassword
  /// Send OTP
  Future<ForgotPasswordModel> sendOTP({required String email});

  /// Reset Password
  Future<ForgotPasswordModel> resetPassword(
      {required String token,
      required String newPassword,
      required String confirmNewPassword});

  /// Category
  Future<CategoryModel> getCategory();
  Future<CategoryAddModel> addCategory(
      {required String name, required String desc, required String image});
  Future<CategoryUpdateModel> categoryUpdate({
    required int id,
    required String name,
    required String desc,
    required String img,
  });

  /// SubCategory   ///
  Future<SubCategoryModel> getSubCategory({required int categoryId});
  Future<SubCategoryPostModel> postSubCategory(
      {required int id, required String name, required String image});
  Future<SubCategoryUpdateModel> updateSubCategory({
    required int categoryID,
    required String name,
    String? image,
    required int subCategoryID,
  });

  /// Product Attribute
  Future<ProductAttributeModel> getProductAttribute();

  ///  Sales Summary
  Future<SalesSummaryModel> getSalesSummary();

  /// Order Statistics
  Future<OrderSummaryModel> getOrderStatistics(String? year);

  /// All Order Status
  Future<AllOrderStatusModel> getAllOrderStatus({required String status});

  ///  get Product
  Future<ProductModelApi> getProduct({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? collectionId,
    int? brandId,
    int? page,
  });

  /// Product Details
  Future<ProductDetailsModel> getProductDetails(int id);

  ///  Add Product
  Future<AddProductModel> addProduct({
    required String productName,
    required int categoryID,
    required int subCategoryID,
    required String productDescription,
    required String productSKU,
    required String status,
    required String type,
    int? childCategoryID,
    int? brandId,
    int? supplierID,
    String? youtubeURL,
    String? gander,
    String? shippingType,
    dynamic shippingCost,
    String? shippingRTNPolicy,
    String? offerStart,
    String? offerEnd,
    String? discountPercent,
    String? multipleQty,
    String? metaName,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
  });

  ///  Update Product
  Future<AddProductModel> updateProduct({
    required int productID,
    required String productName,
    required int categoryID,
    required int subCategoryID,
    required String productDescription,
    required String productSKU,
    required String status,
    required String type,
    int? childCategoryID,
    int? brandId,
    int? supplierID,
    String? youtubeURL,
    String? gander,
    String? shippingType,
    dynamic shippingCost,
    String? shippingRTNPolicy,
    String? offerStart,
    String? offerEnd,
    String? discountPercent,
    String? multipleQty,
    String? metaName,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
  });

  ///   Add Product Variation
  Future<AddProductVariationModel> addProductVariation({
    required List imageList,
    required String productId,
    required String colorID,
    String? codeID,
    required Map<String, dynamic> selectedVariations,
  });

  ///    Update Product Variation
  Future<UpdateProductVariationModel> updateProductVariation({
    required String productId,
    required String variationID,
    required String colorID,
    String? codeID,
    required List imageList,
    required Map<String, dynamic> selectedVariations,
  });

  ///  SortFilter List
  Future<SortFilterListModel> sortFilterList();

  ///  Product Variation List
  Future<ProductVariationListModel> productVariationList();

  /// Search
  Future<ProductModelApi> getSearch({
    required String text,
    String? sort,
    int? filterColorID,
    int? filterSizeID,
    int? page,
  });

  /// Stock
  Future<AdminStockModel> getStock();

  /// Cart
  Future<CartGetModel> getCart(); //Get
  Future<CartPostModel> postCart(
      int productID, int varientID, int qty, int sizeID); //Post Add-to-Cart
  Future<CartItemRemoveModel> removeCart(int id); //Get Remove Cart
  Future<CartUpdateModel> updateCart(
      int productID, int qty, int varientID, int sizeID); //Post Update Cart

  /// Payment type
  Future<PaymentModel> getPaymentType();

  /// Delivery Charge
  Future<DeliveryChargeModel> deliveryCharge(); // Get

  /// Delivery Options
  Future<DeliveryOptionsModel> getDeliveryOptions();

  /// Delivery List
  Future<DeliveryListModel> getDeliveryList(); // Get

  /// Order Place
  //Post
  Future<OrderListPostModel> orderList(
      String shippingAddressId, String paymentType, String isAdvancePayment, String deliveryCharge);
  Future<UserOrderListGetModel> userOrderList({int? page}); //Get
  Future<UserOrderListGetModel> userActiveOrderList({int? page});

  /// Re-Order
  Future<ReOrderModel> reOrder(String invoiceID, String paymentMethod); //Post

  /// Admin Order List
  Future<AdminOrderListModel> adminOrderList();

  /// Admin Order Status
  Future<ChangeAdminOrderStatusModel> changeAdminOrderStatus(
      {required String status, required String invoiceID});

  ///  Admin Order search
  Future<AllOrderStatusModel> adminOrderSearch({required String invoiceID});

  ///  All order Status Count
  Future<AdminOrderCount> adminOrderCount();

  ///   Cancel Order
  Future<CancelOrderModel> cancelOrder({required String invoiceID});

  /// Review
  Future<ReviewGetModel> getReview(String productID); //Post
  Future<ReviewAddModel> addReview(
      int productID, String text, double rating, String file); // Post

  /// Q & A
  Future<QaGetModel> qaList();
  Future<QaAnswer> qaAnswer(String qusID, String productID, String answer);

  /// Currency
  Future<CurrencyModel> getCurrency(); //Get

  /// Shipping Address
  Future<ShippingAddressGetModel> getShippingAddress(); //Get
  Future<ShippingAddressPostModel> addShippingAddress(
    String name,
    String email,
    String phone,
    String area,
    String city,
    String district,
    String address,
    String deliveryCharge,
    String label,
  ); //Post
  ///  Update Shipping Address
  Future<ShippingAddressUpdateModel> updateShippingAddress(
      String name,
      String email,
      String phone,
      String city,
      String district,
      String area,
      String address,
      String label,
      String deliveryCharge,
      int addressID); //Post
  Future<ShippingAddressDeleteModel> deleteShippingAddress(
      int addressID); //Post
  /// Courier
  Future<CourierGetModel> courierList(); //Get

  /// Promos Cuopon
  Future<PromosGetModel> getPromos();
  Future<PromosPostModel> applyPromos(String code);

  ///  Notification
  Future<NotificationModel> getNotification();

  /// Profile
  Future<ProfileGetModel> profileDetails(); // Get
  Future<ProfilePostModel> profileUpdates(
    String name,
    String email,
    String phone,
    String file,
  );

  /// Weekly Order
  Future<TotalWeeklyOrder> getWeeklyOrder(); // Get
  /// Yearly Sell
  Future<YearlySellModel> getYearlySell(String? date);

  /// Financial Status
  Future<FinancialStatusModel> getFinancialStatus(String? date);

  /// Order By Category
  Future<OrderByCategory> getOrderByCategory(); // Get
  ///  Dashboard User count
  Future<DashboardUserCountModel> getDashboardUserCount();

  ///  Get Brand
  Future<BrandModel> getBrands();

  ///  Update Brand
  Future<UpdateBrandModel> updateBrand({
    required int id,
    required String name,
    required String description,
    String? imagePath,
  });

  ///  Add Brand
  Future<AddBrandModel> addBrand({
    required String name,
    required String description,
    required String imagePath,
  });

  /// Supplier
  Future<SupplierGetModel> supplierList();
  Future<SupplierPostModel> supplierAdd(
      {required String name,
      required String phone,
      required String email,
      required String address});
  Future<SupplierUpdateModel> supplierUpdate(
      {required String name,
      required String phone,
      required String email,
      required String address,
      required String id});
  Future<SupplierDeleteModel> supplierDelete({required id});
  // Future<Supplier>
  /// Customers
  Future<CustomersGetModel> getCustomers(); //get
}

class ApiServices implements IApiService {
  // final token = HiveService.getToken();
  final Dio _dio;
  ApiServices()
      : _dio = Dio(BaseOptions(
          validateStatus: (statusCode) {
            // Log.i(statusCode);
            if (statusCode == null) {
              return false;
            }
            if (statusCode == 422 || statusCode == 400) {
              // your http status code
              return true;
            } else {
              return statusCode >= 200 && statusCode < 300;
            }
          },
        )) {
    _dio.interceptors.add(AuthInterceptor());
  }

  ///  Login:
  @override
  Future<LoginModel> loginUser(String email, String password) async {
    final Map<dynamic, dynamic> data = {
      'email': email,
      'password': password,
      'app_token': HelperUtils.firebaseToken.toString(),
    };
    return _handleRequest<LoginModel>(
        () => _dio.post(ApiEndpoint.adminLogin, data: data),
        (dynamic data) => LoginModel.fromJson(data),
        'Login');
  }

  ///  LogOut:
  @override
  Future<LogOutModel> logOutUser() async {
    return _handleRequest<LogOutModel>(() => _dio.post(ApiEndpoint.logout),
        (dynamic data) => LogOutModel.fromJson(data), 'LogOut');
  }

  /// Forgot Password
  /// Send OTP
  @override
  Future<ForgotPasswordModel> sendOTP({required String email}) async {
    final Map<dynamic, dynamic> data = {
      'email': email,
    };
    return _handleRequest<ForgotPasswordModel>(
        () => _dio.post(ApiEndpoint.sendOTP, data: data),
        (dynamic data) => ForgotPasswordModel.fromJson(data),
        'Send OTP');
  }

  ///  Reset Password
  @override
  Future<ForgotPasswordModel> resetPassword(
      {required String token,
      required String newPassword,
      required String confirmNewPassword}) async {
    final Map<String, dynamic> data = {
      'token': token,
      'password': newPassword,
      'password_confirmation': confirmNewPassword,
    };
    return _handleRequest<ForgotPasswordModel>(
        () => _dio.post(ApiEndpoint.resetPassword, queryParameters: data),
        (dynamic data) => ForgotPasswordModel.fromJson(data),
        'Reset Password');
  }

  ///  Category
  @override
  Future<CategoryModel> getCategory() async => _handleRequest<CategoryModel>(
      () => _dio.get(ApiEndpoint.categoryList),
      (dynamic data) => CategoryModel.fromJson(data),
      'Category');

  @override
  Future<CategoryAddModel> addCategory({
    required String name,
    required String desc,
    required String image,
  }) async {
    final FormData data = FormData.fromMap({
      'category_name': name,
      'category_desc': desc,
      'image': await MultipartFile.fromFile(image,
          filename: image), // Pass the file here
    });
    return _handleRequest<CategoryAddModel>(
        () => _dio.post(ApiEndpoint.categoryStore, data: data),
        (dynamic mapper) => CategoryAddModel.fromJson(mapper),
        'Category Add');
  }

  @override
  Future<CategoryUpdateModel> categoryUpdate({
    required int id,
    required String name,
    required String desc,
    String? img,
  }) async {
    Log.w(img);
    final FormData data = FormData.fromMap({
      'category_name': name,
      'category_desc': desc,
      'image': img != null
          ? await MultipartFile.fromFile(img, filename: img)
          : null, // Pass the file here
    });
    return _handleRequest<CategoryUpdateModel>(
        () => _dio.post('${ApiEndpoint.categoryUpdate}/$id', data: data),
        (dynamic mapper) => CategoryUpdateModel.fromJson(mapper),
        'Category Update');
  }

  ///  SubCategory
  @override
  Future<SubCategoryModel> getSubCategory({required int categoryId}) async {
    return _handleRequest<SubCategoryModel>(
        () => _dio.get(
              '${ApiEndpoint.subcategoryList}/$categoryId',
              // queryParameters: data
            ),
        (dynamic data) => SubCategoryModel.fromJson(data),
        'SubCategory');
  }

  @override
  Future<SubCategoryPostModel> postSubCategory({
    required int id,
    required String name,
    required String image,
  }) async {
    final FormData data = FormData.fromMap({
      'category_id': id,
      'name': name,
      'image': await MultipartFile.fromFile(image,
          filename: image), // Pass the file here
    });
    return _handleRequest<SubCategoryPostModel>(
        () => _dio.post(ApiEndpoint.subcategoryStore, data: data),
        (dynamic data) => SubCategoryPostModel.fromJson(data),
        'Sub Category Store');
  }

  /// Update Sub Category
  @override
  Future<SubCategoryUpdateModel> updateSubCategory(
      {required int categoryID,
      required String name,
      String? image,
      required int subCategoryID}) async {
    Log.w(image);
    final FormData data = FormData.fromMap({
      'category_id': categoryID.toString(),
      'name': name,
      // 'image': image, // Pass the file here
    });
    return _handleRequest(
        () => _dio.post(
            '${ApiEndpoint.subcategoryUpdate}/${subCategoryID.toString()}',
            data: data),
        (dynamic data) => SubCategoryUpdateModel.fromJson(data),
        'Sub Category Update');
  }

  ///  ProductAttribute
  @override
  Future<ProductAttributeModel> getProductAttribute() async {
    return _handleRequest<ProductAttributeModel>(
        () => _dio.get(ApiEndpoint.productAttribute),
        (dynamic data) => ProductAttributeModel.fromJson(data),
        "Product Attribute");
  }

  ///    Sales Summary
  @override
  Future<SalesSummaryModel> getSalesSummary() async {
    return _handleRequest<SalesSummaryModel>(
        () => _dio.get(ApiEndpoint.salesSummary),
        (dynamic data) => SalesSummaryModel.fromJson(data),
        "SalesSummary");
  }

  /// Order Statistics
  @override
  Future<OrderSummaryModel> getOrderStatistics(String? year) {
    year ??= DateTime.now().year.toString();
    var data = FormData.fromMap({'year': year});
    return _handleRequest(
        () => _dio.post(ApiEndpoint.getOrderStatistics, data: data),
        (dynamic data) => OrderSummaryModel.fromJson(data),
        'Order Statistics');
  }

  /// All Order Status
  @override
  Future<AllOrderStatusModel> getAllOrderStatus(
      {required String status, int? page}) async {
    var data = FormData.fromMap({'status': status, 'page': page});

    return _handleRequest<AllOrderStatusModel>(
        () => _dio.post(ApiEndpoint.allOrderStatus, data: data),
        (dynamic data) => AllOrderStatusModel.fromJson(data),
        "All Order Status");
  }

  ///  Product
  @override
  Future<ProductModelApi> getProduct({
    String? sort,
    String? filterType,
    int? filterSizeID,
    int? filterColorID,
    int? categoryId,
    int? subCategoryId,
    int? collectionId,
    int? brandId,
    int? page,
  }) async {
    final Map<String, dynamic> data = {
      'sort': sort,
      'filter_type': filterType,
      'filter_size': filterSizeID,
      'filter_color': filterColorID,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'collection_id': collectionId,
      'brand_id':brandId,
      'page': page,
    };
    data.removeWhere((key, value) => value == null);
    return _handleRequest<ProductModelApi>(
            () => _dio.post(ApiEndpoint.productList, queryParameters: data),
            (dynamic data) => ProductModelApi.fromJson(data),
        'Product List');
  }

  /// Product Details
  @override
  Future<ProductDetailsModel> getProductDetails(int id) async {
    final Map<String, int> data = {
      'product_id': id,
    };
    return _handleRequest<ProductDetailsModel>(
        () => _dio.post(ApiEndpoint.productDetails, queryParameters: data),
        (dynamic data) => ProductDetailsModel.fromJson(data),
        'Product Details');
  }

  ///   Add Product
  @override
  Future<AddProductModel> addProduct({
    required String productName,
    required int categoryID,
    required int subCategoryID,
    required String productDescription,
    required String productSKU,
    required String status,
    required String type,
    int? brandId,
    int? supplierID,
    int? childCategoryID,
    String? youtubeURL,
    String? gander,
    String? shippingType,
    dynamic shippingCost,
    String? shippingRTNPolicy,
    String? offerStart,
    String? offerEnd,
    String? discountPercent,
    String? multipleQty,
    String? metaName,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
  }) async {
    final data = FormData.fromMap({
      'product_name': productName,
      'category_id': categoryID,
      'sub_category_id': subCategoryID,
      'child_category_id': childCategoryID,
      'product_description': productDescription,
      'youtube_embadecode': youtubeURL,
      'gander': gander,
      'shipping_type': shippingType,
      'shippig_cost': shippingCost,
      'shipping_rtn_policy': shippingRTNPolicy,
      'offer_start': offerStart,
      'offer_end': offerEnd,
      'discount_percent': discountPercent,
      'multiple_qty': multipleQty,
      'meta_name': metaName,
      'meta_title': metaTitle,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'product_sku': productSKU,
      'status': status,
      'type': type,
      'brand_id': brandId,
      'supplier_id': supplierID,
    });
    return _handleRequest<AddProductModel>(
        () => _dio.post(ApiEndpoint.productStore, data: data),
        (dynamic data) => AddProductModel.fromJson(data),
        ' Add Product');
  }

  ///   Add Product
  @override
  Future<AddProductModel> updateProduct({
    required int productID,
    required String productName,
    required int categoryID,
    required int subCategoryID,
    required String productDescription,
    required String productSKU,
    required String status,
    required String type,
    int? brandId,
    int? supplierID,
    int? childCategoryID,
    String? youtubeURL,
    String? gander,
    String? shippingType,
    dynamic shippingCost,
    String? shippingRTNPolicy,
    String? offerStart,
    String? offerEnd,
    String? discountPercent,
    String? multipleQty,
    String? metaName,
    String? metaTitle,
    String? metaKeywords,
    String? metaDescription,
  }) async {
    final data = FormData.fromMap({
      'product_id': productID,
      'product_name': productName,
      'category_id': categoryID,
      'sub_category_id': subCategoryID,
      'child_category_id': childCategoryID,
      'product_description': productDescription,
      'youtube_embadecode': youtubeURL,
      'gander': gander,
      'shipping_type': shippingType,
      'shippig_cost': shippingCost,
      'shipping_rtn_policy': shippingRTNPolicy,
      'offer_start': offerStart,
      'offer_end': offerEnd,
      'discount_percent': discountPercent,
      'multiple_qty': multipleQty,
      'meta_name': metaName,
      'meta_title': metaTitle,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      'product_sku': productSKU,
      'status': status,
      'type': type,
      'brand_id': brandId,
      'supplier_id': supplierID,
    });
    return _handleRequest<AddProductModel>(
        () => _dio.post(ApiEndpoint.productStore, data: data),
        (dynamic data) => AddProductModel.fromJson(data),
        ' Update Product');
  }

  ///   Add Product Variation
  @override
  Future<AddProductVariationModel> addProductVariation({
    required String productId,
    required String colorID,
    String? codeID,
    required List imageList,
    required Map<String, dynamic> selectedVariations,
  }) async {
    List<MultipartFile> imageFiles = [];
    for (String imagePath in imageList) {
      MultipartFile file = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
      imageFiles.add(file);
    }
    var formData = FormData.fromMap({
      'photos[]': imageFiles,
      'product_id': productId,
      'color_id': colorID,
      'code_id': codeID,
    });
    selectedVariations.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });
    return _handleRequest<AddProductVariationModel>(
        () =>
            _dio.post(ApiEndpoint.productProductVariationStore, data: formData),
        (dynamic data) => AddProductVariationModel.fromJson(data),
        "Add Product Variation");
  }

  ///   Update Product Variation
  @override
  Future<UpdateProductVariationModel> updateProductVariation({
    required String productId,
    required String variationID,
    required String colorID,
    String? codeID,
    required List imageList,
    required Map<String, dynamic> selectedVariations,
  }) async {
    List<MultipartFile> imageFiles = [];
    for (String imagePath in imageList) {
      MultipartFile file = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
      imageFiles.add(file);
    }
    var data = FormData.fromMap({
      'photos[]': imageFiles,
      'product_id': productId,
      'variation_id': variationID,
      'color_id': colorID,
      'code_id': codeID,
    });
    selectedVariations.forEach((key, value) {
      data.fields.add(MapEntry(key, value));
    });
    return _handleRequest<UpdateProductVariationModel>(
        () => _dio.post(ApiEndpoint.productProductVariationUpdate, data: data),
        (dynamic data) => UpdateProductVariationModel.fromJson(data),
        "Update Product Variation");
  }

  ///  SortFilter List
  @override
  Future<SortFilterListModel> sortFilterList() async {
    return _handleRequest<SortFilterListModel>(
        () => _dio.get(ApiEndpoint.sortFilterList),
        (dynamic data) => SortFilterListModel.fromJson(data),
        'Sort Filter List');
  }

  ///  Product Variation List
  @override
  Future<ProductVariationListModel> productVariationList() async {
    return _handleRequest<ProductVariationListModel>(
        () => _dio.get(ApiEndpoint.productVariationList),
        (dynamic data) => ProductVariationListModel.fromJson(data),
        'Product Variation List');
  }

  ///  Search
  @override
  Future<ProductModelApi> getSearch({
    required String text,
    String? sort,
    int? filterColorID,
    int? filterSizeID,
    int? page,
  }) async {
    final Map<String, dynamic> data = {
      'product_search': text,
      'sort': sort,
      'filter_color': filterColorID,
      'filter_size': filterSizeID,
      'page': page,
    };
    return _handleRequest<ProductModelApi>(
            () => _dio.post(ApiEndpoint.search, queryParameters: data),
            (dynamic data) => ProductModelApi.fromJson(data),
        'Search');
  }

  /// Stock
  @override
  Future<AdminStockModel> getStock() async {
    return _handleRequest<AdminStockModel>(
        () => _dio.get(ApiEndpoint.adminStock),
        (dynamic data) => AdminStockModel.fromJson(data),
        'Admin Stock');
  }

  /// Cart
  /// Get Cart List
  @override
  Future<CartGetModel> getCart() async {
    return _handleRequest<CartGetModel>(() => _dio.get(ApiEndpoint.cartList),
        (dynamic data) => CartGetModel.fromJson(data), 'Cart get method');
  }

  ///  Add To Cart
  @override
  Future<CartPostModel> postCart(
      int productID, int varientID, int qty, int sizeID) async {
    final Map<String, int> data = {
      'product_id': productID.toInt(),
      'varient_id': varientID.toInt(),
      'qty': qty.toInt(),
      'size_id': sizeID.toInt()
    };
    return _handleRequest<CartPostModel>(
        () => _dio.post(ApiEndpoint.cartAddToCart, data: data),
        (dynamic data) => CartPostModel.fromJson(data),
        'Cart Post method');
  }

  /// Update Cart
  @override
  Future<CartUpdateModel> updateCart(
      int productID, int qty, int varientID, int sizeID) async {
    final Map<String, dynamic> data = {
      'product_id': productID,
      'qty': qty,
      'varient_id': varientID,
      'size_id': sizeID,
    };
    return _handleRequest<CartUpdateModel>(
        () => _dio.post(ApiEndpoint.cartUpdate, queryParameters: data),
        (dynamic data) => CartUpdateModel.fromJson(data),
        'Cart Update');
  }

  /// Remove To Cart
  @override
  Future<CartItemRemoveModel> removeCart(int id) {
    return _handleRequest<CartItemRemoveModel>(
        () => _dio.get('${ApiEndpoint.cartItemRemove}/$id'),
        (dynamic data) => CartItemRemoveModel.fromJson(data),
        'Cart Remove Item');
  }

  /// Payment Type
  @override
  Future<PaymentModel> getPaymentType() async {
    return _handleRequest<PaymentModel>(() => _dio.get(ApiEndpoint.paymentType),
        (dynamic data) => PaymentModel.fromJson(data), 'Payment Type');
  }

  /// Order List
  @override
  Future<OrderListPostModel> orderList(String shippingAddressId,
      String paymentType, String isAdvancePayment, String deliveryCharge) async {
    var data = FormData.fromMap({
      'shipping_address_id': shippingAddressId.toString(),
      'payment_type': paymentType,
      'advance_payment': isAdvancePayment,
      'delivery_charge' : deliveryCharge,
    });

    return _handleRequest<OrderListPostModel>(
            () => _dio.post(ApiEndpoint.orderList, data: data),
            (dynamic data) => OrderListPostModel.fromJson(data),
        "Order List");
  }

  /// Delivery Charge
  @override
  Future<DeliveryChargeModel> deliveryCharge() async {
    return _handleRequest<DeliveryChargeModel>(
        () => _dio.get(ApiEndpoint.deliveryCharge),
        (dynamic data) => DeliveryChargeModel.fromJson(data),
        'Delivery Charge');
  }

  /// Delivery List
  @override
  Future<DeliveryListModel> getDeliveryList() async {
    return _handleRequest<DeliveryListModel>(
            () => _dio.get(ApiEndpoint.deliveryList),
            (dynamic data) => DeliveryListModel.fromJson(data),
        'Delivery List');
  }

  /// Delivery Options
  @override
  Future<DeliveryOptionsModel> getDeliveryOptions() async {
    return _handleRequest<DeliveryOptionsModel>(
          () => _dio.get(ApiEndpoint.deliveryOptions),
          (dynamic data) => DeliveryOptionsModel.fromJson(data),
      'Delivery Options',
    );
  }

  /// Re-Order
  @override
  Future<ReOrderModel> reOrder(String invoiceID, String paymentMethod) async {
    final Map<String, dynamic> data = ({
      'invoiceID': invoiceID,
      'paymentMethod': paymentMethod,
    });
    return _handleRequest<ReOrderModel>(
        () => _dio.post(ApiEndpoint.reOrder, queryParameters: data),
        (dynamic data) => ReOrderModel.fromJson(data),
        'Re-Order Model');
  }

  /// Admin Order List
  @override
  Future<AdminOrderListModel> adminOrderList() async {
    return _handleRequest<AdminOrderListModel>(
        () => _dio.get(ApiEndpoint.adminOrderList),
        (dynamic data) => AdminOrderListModel.fromJson(data),
        'Admin Order List');
  }

  ///  Admin Orders Count
  @override
  Future<AdminOrderCount> adminOrderCount() {
    return _handleRequest<AdminOrderCount>(
        () => _dio.get(ApiEndpoint.adminOrderCount),
        (dynamic data) => AdminOrderCount.fromJson(data),
        'Admin Order Count');
  }

  /// Change Admin Order Status
  @override
  Future<ChangeAdminOrderStatusModel> changeAdminOrderStatus(
      {required String status, required String invoiceID}) async {
    var data = FormData.fromMap({
      'invoiceID': invoiceID,
      'status': status,
    });
    return _handleRequest<ChangeAdminOrderStatusModel>(
        () => _dio.post(ApiEndpoint.adminOrderStatus, data: data),
        (dynamic data) => ChangeAdminOrderStatusModel.fromJson(data),
        'Change Admin Order Status');
  }

  ///  Admin Order Search
  @override
  Future<AllOrderStatusModel> adminOrderSearch(
      {required String invoiceID}) async {
    var data = json.encode({"invoiceID": invoiceID});
    return _handleRequest<AllOrderStatusModel>(
        () => _dio.post(ApiEndpoint.adminOrderSearch, data: data),
        (dynamic data) => AllOrderStatusModel.fromJson(data),
        'Admin Order Search');
  }

  ///  Cancel Order
  @override
  Future<CancelOrderModel> cancelOrder({required String invoiceID}) async {
    var data = FormData.fromMap({
      'invoiceID': invoiceID,
    });
    return _handleRequest<CancelOrderModel>(
        () => _dio.post(ApiEndpoint.cancelOrder, data: data),
        (dynamic data) => CancelOrderModel.fromJson(data),
        'Cancel Order');
  }

  /// User order Post
  @override
  Future<UserOrderListGetModel> userOrderList({int? page}) async {
    final Map<String, dynamic> data = {
      'page': page,
    };
    return _handleRequest<UserOrderListGetModel>(
        () => _dio.post(ApiEndpoint.userOrderList, queryParameters: data),
        (dynamic data) => UserOrderListGetModel.fromJson(data),
        "User Order List");
  }

  /// User active order Post
  @override
  Future<UserOrderListGetModel> userActiveOrderList({int? page}) async {
    final Map<String, dynamic> data = {
      'status': 'Active',
      'page': page,
    };
    return _handleRequest<UserOrderListGetModel>(
        () => _dio.post(ApiEndpoint.userOrderList, queryParameters: data),
        (dynamic data) => UserOrderListGetModel.fromJson(data),
        "User Active Order List");
  }

  /// Review
  //Get
  @override
  Future<ReviewGetModel> getReview(String productID) async {
    var data = FormData.fromMap({'product_id': productID});
    return _handleRequest<ReviewGetModel>(
        () => _dio.post(ApiEndpoint.reviewList, data: data),
        (dynamic data) => ReviewGetModel.fromJson(data),
        'Review List'); // Post
  }

  // Post
  @override
  Future<ReviewAddModel> addReview(
      int productID, String text, double rating, String file) async {
    var data = FormData.fromMap({
      'product_id': productID,
      'text': text,
      'rating': rating.toString(),
      'image': await MultipartFile.fromFile(file, filename: file),
    });
    return _handleRequest<ReviewAddModel>(
        () => _dio.post(ApiEndpoint.reviewAdd, data: data),
        (dynamic data) => ReviewAddModel.fromJson(data),
        'Review Add');
  }

  /// Currency
  @override
  Future<CurrencyModel> getCurrency() async {
    return _handleRequest<CurrencyModel>(
        () => _dio.get(ApiEndpoint.getCurrency),
        (dynamic data) => CurrencyModel.fromJson(data),
        'Currency');
  }

  /// Q & A
  @override
  Future<QaGetModel> qaList() async {
    return _handleRequest<QaGetModel>(() => _dio.get(ApiEndpoint.qaList),
        (dynamic data) => QaGetModel.fromJson(data), 'Q&A List');
  }

  @override
  Future<QaAnswer> qaAnswer(
      String qusID, String productID, String answer) async {
    var data = FormData.fromMap({
      'admin_id': 1.toString(),
      'question_id': qusID,
      'product_id': productID,
      'answer': answer,
    });
    return _handleRequest<QaAnswer>(
        () => _dio.post(ApiEndpoint.qaAnswer, data: data),
        (dynamic data) => QaAnswer.fromJson(data),
        'QA Answer');
  }

  /// Shipping Address
  //Get
  @override
  Future<ShippingAddressGetModel> getShippingAddress() async {
    return _handleRequest<ShippingAddressGetModel>(
        () => _dio.get(ApiEndpoint.addressList),
        (dynamic data) => ShippingAddressGetModel.fromJson(data),
        'Shipping Address List');
  }

  //Post
  @override
  Future<ShippingAddressPostModel> addShippingAddress(
    String name,
    String email,
    String phone,
    String city,
    String district,
    String area,
    String address,
    String deliveryCharge,
    String label,
  ) async {
    final Map<String, String> data = {
      'label': label,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'district': district,
      'selected_area': area,
      'delivery_charge': deliveryCharge,
      'address': address,
    };
    return _handleRequest<ShippingAddressPostModel>(
        () => _dio.post(ApiEndpoint.addressAdd, data: data),
        (dynamic data) => ShippingAddressPostModel.fromJson(data),
        'Add Shipping Address');
  }

  // Post Update
  @override
  Future<ShippingAddressUpdateModel> updateShippingAddress(
    String label,
    String name,
    String phone,
    String email,
    String city,
    String district,
    String area,
    String address,
    String deliveryCharge,
    int addressID,
  ) async {
    final Map<String, dynamic> data = {
      'label': label,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'district': district,
      'selected_area': area,
      'address': address,
      'delivery_charge': deliveryCharge,
      'shipping_address_id': addressID,
    };
    return _handleRequest<ShippingAddressUpdateModel>(
        () => _dio.post(ApiEndpoint.addressUpdate, data: data),
        (dynamic data) => ShippingAddressUpdateModel.fromJson(data),
        'Update Shipping Address');
  }

  // Post Delete
  @override
  Future<ShippingAddressDeleteModel> deleteShippingAddress(
      int addressID) async {
    final data = FormData.fromMap({
      'shipping_address_id': addressID,
    });
    return _handleRequest<ShippingAddressDeleteModel>(
        () => _dio.post(ApiEndpoint.addressDelete, data: data),
        (dynamic data) => ShippingAddressDeleteModel.fromJson(data),
        'Delete Shipping Address');
  }

  /// Courier
  // Get courierList
  @override
  Future<CourierGetModel> courierList() async {
    return _handleRequest<CourierGetModel>(() => _dio.get(ApiEndpoint.cartList),
        (dynamic data) => CourierGetModel.fromJson(data), 'Courier Get');
  }

  /// Promos Coupon
  @override
  Future<PromosGetModel> getPromos() async {
    return _handleRequest<PromosGetModel>(
        () => _dio.get(ApiEndpoint.couponList),
        (dynamic data) => PromosGetModel.fromJson(data),
        'Promos');
  }

  // Post
  @override
  Future<PromosPostModel> applyPromos(String code) async {
    final Map<String, dynamic> data = {
      'coupon_code': code,
    };
    return _handleRequest<PromosPostModel>(
        () => _dio.post(ApiEndpoint.couponApply, data: data),
        (dynamic data) => PromosPostModel.fromJson(data),
        'Promos Apply');
  }

  /// Notification
  @override
  Future<NotificationModel> getNotification() async {
    return _handleRequest<NotificationModel>(
        () => _dio.get(ApiEndpoint.notification),
        (dynamic data) => NotificationModel.fromJson(data),
        'Notification');
  }

  /// Profile
  /// Get
  @override
  Future<ProfileGetModel> profileDetails() async {
    return _handleRequest<ProfileGetModel>(
        () => _dio.get(ApiEndpoint.profileDetails),
        (dynamic data) => ProfileGetModel.fromJson(data),
        'Profile Details');
  }

  /// Post
  @override
  Future<ProfilePostModel> profileUpdates(
    String name,
    String email,
    String phone,
    String file,
  ) async {
    var data = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'files': await MultipartFile.fromFile(file, filename: file)
    });
    return _handleRequest<ProfilePostModel>(
        () => _dio.post(ApiEndpoint.profileUpdate, data: data),
        (dynamic data) => ProfilePostModel.fromJson(data),
        'Profile Update');
  }

  /// Weekly Order
  @override
  Future<TotalWeeklyOrder> getWeeklyOrder() async {
    return _handleRequest<TotalWeeklyOrder>(
        () => _dio.get(ApiEndpoint.totalWeeklyOrder),
        (dynamic data) => TotalWeeklyOrder.fromJson(data),
        'Dashboard Weekly Order');
  }

  /// Yearly Sell
  @override
  Future<YearlySellModel> getYearlySell(String? date) async {
    date ??= DateTime.now().year.toString();
    var data = FormData.fromMap({
      'year': date,
    });
    return _handleRequest<YearlySellModel>(
        () => _dio.post(ApiEndpoint.yearlySell, data: data),
        (dynamic data) => YearlySellModel.fromJson(data),
        'Yearly Sell');
  }

  /// Financial Status
  @override
  Future<FinancialStatusModel> getFinancialStatus(String? date) async {
    date ??=
        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}';
    var data = FormData.fromMap({
      'month': date,
    });
    return _handleRequest<FinancialStatusModel>(
        () => _dio.post(ApiEndpoint.financialStatus, data: data),
        (dynamic data) => FinancialStatusModel.fromJson(data),
        'Financial Status');
  }

  /// Order By Category
  @override
  Future<OrderByCategory> getOrderByCategory() async {
    return _handleRequest<OrderByCategory>(
        () => _dio.get(ApiEndpoint.orderByCategory),
        (dynamic data) => OrderByCategory.fromJson(data),
        'Order By Category');
  }

  ///  Dashboard user count
  @override
  Future<DashboardUserCountModel> getDashboardUserCount() async {
    return _handleRequest<DashboardUserCountModel>(
        () => _dio.get(ApiEndpoint.dashboardUserCount),
        (dynamic data) => DashboardUserCountModel.fromJson(data),
        'Dashboard user count Api');
  }

  ///    Brands
  @override
  Future<BrandModel> getBrands() async {
    return _handleRequest<BrandModel>(() => _dio.get(ApiEndpoint.brandList),
        (dynamic data) => BrandModel.fromJson(data), "Get Brands");
  }

  ///  Update Brand
  @override
  Future<UpdateBrandModel> updateBrand({
    required int id,
    required String name,
    required String description,
    String? imagePath,
  }) async {
    final data = FormData.fromMap({
      'name': name,
      'desc': description,
      'image': imagePath != null
          ? await MultipartFile.fromFile(imagePath, filename: imagePath)
          : null,
    });
    return _handleRequest<UpdateBrandModel>(
        () => _dio.post("${ApiEndpoint.brandUpdate}$id", data: data),
        ((dynamic data) => UpdateBrandModel.fromJson(data)),
        'Update Brand');
  }

  ///  Add Brand
  @override
  Future<AddBrandModel> addBrand({
    required String name,
    required String description,
    required String imagePath,
  }) async {
    final data = FormData.fromMap({
      'name': name,
      'desc': description,
      'image': await MultipartFile.fromFile(imagePath, filename: imagePath),
    });
    return _handleRequest<AddBrandModel>(
        () => _dio.post(ApiEndpoint.brandStore, data: data),
        ((dynamic data) => AddBrandModel.fromJson(data)),
        'Add Brand');
  }

  /// Supplier
  @override
  Future<SupplierGetModel> supplierList() async {
    return _handleRequest<SupplierGetModel>(
        () => _dio.get(ApiEndpoint.supplierGet),
        (dynamic data) => SupplierGetModel.fromJson(data),
        'Supplier Get List');
  }

  @override
  Future<SupplierPostModel> supplierAdd({
    required String name,
    required String phone,
    required String email,
    required String address,
  }) async {
    final Map<String, dynamic> data = {
      'supplierName': name,
      'supplierPhone': phone,
      'supplierEmail': email,
      'supplierAddress': address,
    };
    return _handleRequest<SupplierPostModel>(
      () => _dio.post(ApiEndpoint.supplierPost, queryParameters: data),
      (dynamic data) => SupplierPostModel.fromJson(data),
      'Supplier Add',
    );
  }

  @override
  Future<SupplierUpdateModel> supplierUpdate({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String id,
  }) async {
    final Map<String, dynamic> data = {
      'supplierName': name,
      'supplierPhone': phone,
      'supplierEmail': email,
      'supplierAddress': address,
    };
    return _handleRequest<SupplierUpdateModel>(
        () => _dio.post('${ApiEndpoint.supplierUpdate}/$id',
            queryParameters: data),
        (dynamic data) => SupplierUpdateModel.fromJson(data),
        'Supplier Update');
  }

  @override
  Future<SupplierDeleteModel> supplierDelete({required id}) async {
    return _handleRequest(
        () => _dio.post('${ApiEndpoint.supplierDelete}/$id'),
        (dynamic data) => SupplierDeleteModel.fromJson(data),
        'Supplier Delete');
  }

  /// Customers
  @override
  Future<CustomersGetModel> getCustomers() async {
    return _handleRequest<CustomersGetModel>(
        () => _dio.get(ApiEndpoint.getCustomers),
        (dynamic data) => CustomersGetModel.fromJson(data),
        'Customers');
  }
}

// Handle API request and response with error handling
Future<T> _handleRequest<T>(Future<Response<dynamic>> Function() request,
    T Function(dynamic) mapper, String apiName) async {
  try {
    final response = await request();
    // Log.i('Print Status Code');
    // Log.i(response.statusCode);
    // Log.i(response.data);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 422) {
      debugPrint('Api Name: $apiName');
      return mapper(response.data);
    } else {
      Log.i('Api Exception Error ${response.toString()}');
      throw ApiException('Failed to load data: ${response.statusCode}',
          statusCode: response.statusCode!);
    }
  } catch (e) {
    Log.i('Error $apiName : ${e.toString()}');
    throw ApiException('Failed to load data: $e', statusCode: 500);
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, {this.statusCode = 500});
}
