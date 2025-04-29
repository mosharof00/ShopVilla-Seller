import 'package:get/get.dart';

import '../models/category/addCategory/bindings/add_category_binding.dart';
import '../models/category/addCategory/views/add_category_view.dart';
import '../models/category/addSubCategory/bindings/add_sub_category_binding.dart';
import '../models/category/addSubCategory/views/add_sub_category_view.dart';
import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/auth/forgot_password/change_password/bindings/change_password_binding.dart';
import '../modules/auth/forgot_password/change_password/views/change_password_view.dart';
import '../modules/auth/forgot_password/verify_OTP/bindings/verify_o_t_p_binding.dart';
import '../modules/auth/forgot_password/verify_OTP/views/verify_o_t_p_view.dart';
import '../modules/auth/forgot_password/views/forgot_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/brand/bindings/brand_binding.dart';
import '../modules/brand/views/brand_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/category_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/choose_delivery/bindings/choose_delivery_binding.dart';
import '../modules/choose_delivery/views/choose_delivery_view.dart';
import '../modules/choose_delivery_address/add_delivery_address/bindings/add_delivery_address_binding.dart';
import '../modules/choose_delivery_address/add_delivery_address/views/add_delivery_address_view.dart';
import '../modules/choose_delivery_address/bindings/choose_delivery_address_binding.dart';
import '../modules/choose_delivery_address/views/choose_delivery_address_view.dart';
import '../modules/customer/bindings/customer_binding.dart';
import '../modules/customer/views/customer_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/edit_product/bindings/edit_product_binding.dart';
import '../modules/edit_product/views/edit_product_view.dart';
import '../modules/financial_status/bindings/financial_status_binding.dart';
import '../modules/financial_status/views/financial_status_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/leave_review/bindings/leave_review_binding.dart';
import '../modules/leave_review/views/leave_review_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/my_order/bindings/my_order_binding.dart';
import '../modules/my_order/views/my_order_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/order_details/bindings/order_details_binding.dart';
import '../modules/order_details/views/order_details_view.dart';
import '../modules/order_info/bindings/order_info_binding.dart';
import '../modules/order_info/views/order_info_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/productDetails/bindings/product_details_binding.dart';
import '../modules/products/productDetails/views/product_details_view.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/accountAndSecurity/bindings/account_and_security_binding.dart';
import '../modules/profile/accountAndSecurity/views/account_and_security_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/editProfile/bindings/edit_profile_binding.dart';
import '../modules/profile/editProfile/views/edit_profile_view.dart';
import '../modules/profile/helpAndSupport/bindings/help_and_support_binding.dart';
import '../modules/profile/helpAndSupport/views/help_and_support_view.dart';
import '../modules/profile/notifications/bindings/notifications_binding.dart';
import '../modules/profile/notifications/views/notifications_view.dart';
import '../modules/profile/paymentMethods/addNewPayment/bindings/add_new_payment_binding.dart';
import '../modules/profile/paymentMethods/addNewPayment/views/add_new_payment_view.dart';
import '../modules/profile/paymentMethods/bindings/payment_methods_binding.dart';
import '../modules/profile/paymentMethods/views/payment_methods_view.dart';
import '../modules/profile/settings/bindings/settings_binding.dart';
import '../modules/profile/settings/views/settings_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promos_vouchers/bindings/promos_vouchers_binding.dart';
import '../modules/promos_vouchers/views/promos_vouchers_view.dart';
import '../modules/qus_and_ans/bindings/qus_and_ans_binding.dart';
import '../modules/qus_and_ans/views/qus_and_ans_view.dart';
import '../modules/recent_orders/bindings/recent_orders_binding.dart';
import '../modules/recent_orders/recent_orders_list/bindings/recent_orders_list_binding.dart';
import '../modules/recent_orders/recent_orders_list/views/recent_orders_list_view.dart';
import '../modules/recent_orders/views/recent_orders_view.dart';
import '../modules/sales_summary/bindings/sales_summary_binding.dart';
import '../modules/sales_summary/views/sales_summary_view.dart';
import '../modules/searching/bindings/searching_binding.dart';
import '../modules/searching/views/searching_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/stocks/bindings/stocks_binding.dart';
import '../modules/stocks/stocks_details/bindings/stocks_details_binding.dart';
import '../modules/stocks/stocks_details/views/stocks_details_view.dart';
import '../modules/stocks/views/stocks_view.dart';
import '../modules/supplier/bindings/supplier_binding.dart';
import '../modules/supplier/views/supplier_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/chat/bindings/chat_binding.dart';
import '../modules/support/chat/views/chat_view.dart';
import '../modules/support/views/support_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.FINANCIAL_STATUS,
      page: () => const FinancialStatusView(),
      binding: FinancialStatusBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.PAYMENT_METHODS,
          page: () => const PaymentMethodsView(),
          binding: PaymentMethodsBinding(),
          children: [
            GetPage(
              name: _Paths.ADD_NEW_PAYMENT,
              page: () => const AddNewPaymentView(),
              binding: AddNewPaymentBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => const EditProfileView(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => const SettingsView(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: _Paths.ACCOUNT_AND_SECURITY,
          page: () => const AccountAndSecurityView(),
          binding: AccountAndSecurityBinding(),
        ),
        GetPage(
          name: _Paths.HELP_AND_SUPPORT,
          page: () => const HelpAndSupportView(),
          binding: HelpAndSupportBinding(),
        ),
        GetPage(
          name: _Paths.NOTIFICATIONS,
          page: () => const NotificationsView(),
          binding: NotificationsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
      children: [
        GetPage(
          name: _Paths.PRODUCT_DETAILS,
          page: () => const ProductDetailsView(),
          binding: ProductDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.QUS_AND_ANS,
      page: () => const QusAndAnsView(),
      binding: QusAndAnsBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_DELIVERY_ADDRESS,
      page: () => const ChooseDeliveryAddressView(),
      binding: ChooseDeliveryAddressBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_DELIVERY_ADDRESS,
          page: () => const AddDeliveryAddressView(),
          binding: AddDeliveryAddressBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHOOSE_DELIVERY,
      page: () => const ChooseDeliveryView(),
      binding: ChooseDeliveryBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_METHODS,
      page: () => const PaymentMethodsView(),
      binding: PaymentMethodsBinding(),
    ),
    GetPage(
      name: _Paths.PROMOS_VOUCHERS,
      page: () => const PromosVouchersView(),
      binding: PromosVouchersBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER,
      page: () => const MyOrderView(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_REVIEW,
      page: () => const LeaveReviewView(),
      binding: LeaveReviewBinding(),
    ),
    GetPage(
      name: _Paths.SALES_SUMMARY,
      page: () => const SalesSummaryView(),
      binding: SalesSummaryBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_INFO,
      page: () => const OrderInfoView(),
      binding: OrderInfoBinding(),
    ),
    GetPage(
      name: _Paths.RECENT_ORDERS,
      page: () => const RecentOrdersView(),
      binding: RecentOrdersBinding(),
      children: [
        GetPage(
          name: _Paths.RECENT_ORDERS_LIST,
          page: () => const RecentOrdersListView(),
          binding: RecentOrdersListBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.STOCKS,
      page: () => const StocksView(),
      binding: StocksBinding(),
      children: [
        GetPage(
          name: _Paths.STOCKS_DETAILS,
          page: () => const StocksDetailsView(),
          binding: StocksDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
      children: [
        GetPage(
          name: _Paths.CHAT,
          page: () => const ChatView(),
          binding: ChatBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: _Paths.LOGIN,
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: _Paths.FORGOT_PASSWORD,
          page: () => const ForgotPasswordView(),
          binding: ForgotPasswordBinding(),
          children: [
            GetPage(
              name: _Paths.VERIFY_O_T_P,
              page: () => const VerifyOTPView(),
              binding: VerifyOTPBinding(),
            ),
            GetPage(
              name: _Paths.CHANGE_PASSWORD,
              page: () => const ChangePasswordView(),
              binding: ChangePasswordBinding(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHING,
      page: () => const SearchingView(),
      binding: SearchingBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const CategoryView(),
      binding: CategoryBinding(),
      children: [
        GetPage(
          name: _Paths.ADD_CATEGORY,
          page: () => const AddCategoryView(),
          binding: AddCategoryBinding(),
        ),
        GetPage(
          name: _Paths.ADD_SUB_CATEGORY,
          page: () => const AddSubCategoryView(),
          binding: AddSubCategoryBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.BRAND,
      page: () => const BrandView(),
      binding: BrandBinding(),
    ),
    GetPage(
      name: _Paths.SUPPLIER,
      page: () => const SupplierView(),
      binding: SupplierBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => const EditProductView(),
      binding: EditProductBinding(),
    ),
  ];
}
