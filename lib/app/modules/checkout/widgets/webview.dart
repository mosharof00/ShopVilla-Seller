import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:shop_villa_seller/helper/helper_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;

  const PaymentWebViewScreen({super.key, required this.url});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  final checkoutController = Get.put(CheckoutController());
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            checkoutController.isLoading.value = true;
            checkoutController.showLoadingDialog();
          },
          onProgress: (int progress) {
            // Handle progress updates if necessary
          },
          onPageFinished: (String url) {
            checkoutController.isLoading.value = false;
            checkoutController.closeLoadingDialogIfOpen();
            // Handle payment success/failure based on URL
            if (url.contains("/api/success") ||
                url.contains('/api/stripe/success') ||
                url.contains('status=success') ||
                url.contains('api/razorpay/success')) {
              HelperUtils.navigateToOrder();
              Get.snackbar('Payment Success', 'Thank you!.');
            } else if (url.contains("api/fail")) {
              Get.back(); // Dismiss the WebView
              HelperUtils.navigateToOrder();
              Get.snackbar('Payment failed', 'Please try again.');
            }
          },
          onWebResourceError: (WebResourceError error) {
            checkoutController.isLoading.value = false;
            // Close the loading dialog
            Get.snackbar(
                'Error', 'Failed to load the payment page. Please try again.');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Prevent navigation to disallowed URLs
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          surfaceTintColor: ColorName.white,
          backgroundColor: ColorName.white,
          title: appbarTitle(text: 'Payment Gateway'),
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
