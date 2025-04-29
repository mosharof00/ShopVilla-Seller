import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/app/repository/api_endpoint.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../../../global/app_text_style.dart';
import '../../../../../global/methods/url_launcher.dart';
import '../../widgets/custom_option.dart';
import '../controllers/help_and_support_controller.dart';

class HelpAndSupportView extends GetView<HelpAndSupportController> {
  const HelpAndSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        title: appbarTitle(text: 'Help & Support'),
        centerTitle: true,
        backgroundColor: ColorName.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "FAQ",
              ),
              // customOption(
              //   onTap: () {}, text: "Contact Support",
              //     UrlLauncher.url(ApiEndpoint.domainUrl);
              // ),
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "Privacy Policy",
              ),
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "Terms of Service",
              ),
              // customOption(
              //   onTap: () {},
              //   text: "Accessibility",
              // ),
              // customOption(
              //   onTap: () {},
              //   text: "FeedBack",
              // ),
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "About us",
              ),
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "Rate us",
              ),
              customOption(
                onTap: () {
                  UrlLauncher.url(ApiEndpoint.domainUrl);
                },
                text: "Visit Our Website",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
