import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../global/log_printer.dart';
import '../../helper/helper_utils.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (HelperUtils.token != "") {
      options.headers['Authorization'] = 'Bearer ${HelperUtils.token}';
    }
    super.onRequest(options, handler);
    debugPrint("Bearer token ----------------${HelperUtils.token}");
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Log.i(response.statusCode!);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response != null && err.response!.statusCode == 401) {
      // Handle unauthenticated case
      HelperUtils.isLogin = false;
      // Optionally, log the error or show a message
      Log.i('Unauthenticated error: ${err.message}');
      // Optionally, navigate to login screen or handle token expiration
      // Example: Get.offAllNamed('/login'); // Navigate to login screen
    }
    super.onError(err, handler);
  }
}
