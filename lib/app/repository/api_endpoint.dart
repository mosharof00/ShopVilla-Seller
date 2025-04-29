class ApiEndpoint {
  ///  Base URL
  // static const String domainUrl = 'https://shopaholic.arcadexit.com';
  static const String domainUrl = 'https://devshopaholic.arcadexit.com';
  static const String baseUrl = '$domainUrl/api';

  ///  Auth
  static const String register = '$baseUrl/register'; // post
  static const String login = '$baseUrl/login'; // post
  static const String adminLogin = '$baseUrl/admin-login'; // post
  static const String logout = '$baseUrl/dashboard/logout'; // post
  static const String sendOTP = '$baseUrl/forget-password/send-otp'; // post
  static const String resetPassword =
      '$baseUrl/forget-password/reset-password'; // post
  ///  Category
  static const String categoryList = '$baseUrl/category/list'; // get
  static const String categoryStore = '$baseUrl/category/store'; // post
  static const String categoryUpdate = '$baseUrl/category/update'; // post
  ///  subcategory
  static const String subcategoryList = '$baseUrl/subcategory/list'; // get
  static const String subcategoryStore = '$baseUrl/subcategory/store'; // post
  static const String subcategoryUpdate =
      '$baseUrl/subcategory/update'; // post
  ///  childCategory
  static const String childCategoryList = '$baseUrl/childcategory/list'; // get
  static const String childCategoryStore =
      '$baseUrl/childcategory/store'; // post
  static const String childCategoryUpdate1 =
      '$baseUrl/childcategory/update/1'; // post
  ///  brand
  static const String brandList = '$baseUrl/brand/list'; // get
  static const String brandStore = '$baseUrl/brand/store'; // post
  static const String brandUpdate = '$baseUrl/brand/update/'; // post
  ///  product
  static const String productList = '$baseUrl/product/list'; // get
  static const String productDetails = '$baseUrl/product/details'; // get
  static const String productVariationList =
      '$baseUrl/product/product/variation'; // get
  static const String productProductVariationStore =
      '$baseUrl/product/variation/store'; // post
  static const String productProductVariationUpdate =
      '$baseUrl/product/variation/update'; // post

  static const String sortFilterList = '$baseUrl/product/sort-type'; // get
  static const String productStore = '$baseUrl/product/store'; // post

  /// Product Attribute
  static const String productAttribute =
      '$baseUrl/product-attribute/list'; // get
  ///  Search
  static const String search = '$baseUrl/search'; // post
  /// Stock
  static const String adminStock = '$baseUrl/admin/stock';
  /// Delivery Charge
  static const String deliveryCharge = '$baseUrl/delivary-charge' ; // Get
  static const String deliveryList = '$baseUrl/delivary-city'; // Get
  static const String deliveryOptions = '$baseUrl/delivary-option'; // Get

  ///  cart
  static const String cartList = '$baseUrl/cart/list'; // Get
  static const String cartAddToCart = '$baseUrl/cart/addtocart'; // Post
  static const String cartUpdate = '$baseUrl/cart/addtocart/update'; // Post
  static const String cartItemRemove = '$baseUrl/cart/remove/cart/item'; //Get
  ///  checkOut
  static const String checkList = '$baseUrl/checkout/list'; // Get
  /// Payment Type
  static const String paymentType = '$baseUrl/payment-type'; // Get
  /// Order
  static const String orderList = '$baseUrl/checkout/order'; // Post
  static const String userOrderList = '$baseUrl/user/order/list'; // Post
  static const String adminOrderList = '$baseUrl/admin/order/list'; //Get
  static const String adminOrderStatus = '$baseUrl/admin/order/status'; //Post
  static const String cancelOrder = '$baseUrl/user/order/cancel'; //Post
  static const String adminOrderCount = '$baseUrl/admin/count-order'; //Post
  static const String adminOrderSearch = '$baseUrl/admin/find-order'; //Post
  /// Re-Order
  static const String reOrder = '$baseUrl/checkout/re-order'; //Post

  ///  wishlist
  static const String wishlistList = '$baseUrl/wishlist/list'; // Get
  static const String wishlistAddWishlist =
      '$baseUrl/wishlist/add/wishlist'; // post
  static const String wishlistRemoveWishlist =
      '$baseUrl/wishlist/remove/wishlist'; // post
  static const String wishlistRemoveAllWishlist =
      '$baseUrl/wishlist/remove/all/wishlist'; // post
  /// Shipping Address
  static const String addressList = '$baseUrl/shipping-address/list'; //Get
  static const String addressAdd = '$baseUrl/shipping-address/store'; //Post
  static const String addressUpdate = '$baseUrl/shipping-address/update'; //Post
  static const String addressDelete =
      '$baseUrl/shipping-address/destroy'; //Post
  /// Courier
  static const String courierList = '$baseUrl/courier/list'; // Get
  /// Supplier
  static const String supplierGet = '$baseUrl/suppliers/list'; // Get
  static const String supplierPost = '$baseUrl/suppliers/store'; // Post
  static const String supplierUpdate = '$baseUrl/suppliers/update'; // Post
  static const String supplierDelete = '$baseUrl/suppliers/destroy'; // Post

  /// Customers
  static const String getCustomers = '$baseUrl/customer/list'; //Get
  /// Slider
  static const String slider = '$baseUrl/slider/list';

  /// Reviews
  static const String reviewList = '$baseUrl/review/list'; //Get
  static const String reviewAdd = '$baseUrl/review/store'; //Post Store
  static const String reviewUpdate = '$baseUrl/review/update/1'; //Post Update
  /// Currency
  static const String getCurrency = '$baseUrl/currency/list' ; // Get
  /// Q & A
  static const String qaList = '$baseUrl/list';
  static const String qaAnswer = '$baseUrl/answer';

  /// Promos Coupon
  static const String couponList = '$baseUrl/coupon/list'; //Get
  /// Notification
  static const String notification = '$baseUrl/user-notification'; //Get
  static const String couponApply = '$baseUrl/coupon/apply'; //Post
  /// Profile
  static const String profileDetails = '$baseUrl/profile/details'; //Get
  static const String profileUpdate = '$baseUrl/profile/update'; //Post
  ///  logOut
  static const String dashboardLogout = '$baseUrl/dashboard/logout'; // post
  ///  newCollection
  static const String bazar365Api = '$baseUrl/dashboard/logout'; // get
  /// Sales Summary
  static const String salesSummary = '$baseUrl/sales/list'; // get
  static const String allOrderStatus = '$baseUrl/admin/order/list';// post
  static const String getOrderStatistics = '$baseUrl/sales/yearly-sell';// post
  /// Total Weekly Order
  static const String totalWeeklyOrder = '$baseUrl/dashboard'; // Get
  ///Financial Status
  static const String financialStatus = '$baseUrl/financial/list'; //Post
  /// Yearly Sell
  static const String yearlySell = '$baseUrl/financial/sales-data'; //Post
  /// Order By Category
  static const String orderByCategory =
      '$baseUrl/financial/order-by-category'; // Get
  ///  dashboard count
  static const String dashboardUserCount = '$baseUrl/dashboard/all-count';
}
