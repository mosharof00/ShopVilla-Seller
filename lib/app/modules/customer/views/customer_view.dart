import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_villa_seller/gen/colors.gen.dart';
import 'package:shop_villa_seller/global/app_text_style.dart';
import 'package:shop_villa_seller/global/cashed_image_helper.dart';
import 'package:shop_villa_seller/global/loadingAnimationWidget.dart';
import 'package:shop_villa_seller/global/sizedbox_extension.dart';
import 'package:shop_villa_seller/helper/appbar_title.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../global/not_search_items_found_widget.dart';
import '../../../models/Customers/customers_get_model.dart';
import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.bgColor,
      appBar: AppBar(
        backgroundColor: ColorName.bgColor,
        surfaceTintColor: ColorName.bgColor,
        title: appbarTitle(text: 'Customers'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return loadingAnimationWidget();
        } else if (controller.customerList.isEmpty) {
          return NotSearchedItemFoundWidget(
            iconSvgPath: Assets.images.emptySearch,
            heightLogo: 150.h,
            widthLogo: 150.w,
            title: 'Empty Customer',
            description: "No Customers have been added yet.",
          );
        } else {
          return ListView.builder(
            itemCount:
                controller.customerList.length, // Assuming you have 10 items
            itemBuilder: (context, index) {
              final Customers customers = controller.customerList[index];
              return Container(
                padding: const EdgeInsets.all(20), // Padding inside the card
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Margin around the card
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color
                      blurRadius: 10, // Softness of the shadow
                      spreadRadius: 5, // Spread radius
                      offset: const Offset(0, 5), // Vertical offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Row (Name, Call Button, More Options)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        circularImage(imgUrl: customers.image!),
                        5.width,
                        // User name and email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextStyle(
                                text: customers.name!,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              AppTextStyle(
                                text: customers.email!,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorName.gray410,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        // Call Button
                        // IconButton(
                        //   icon: const Icon(Icons.call, color: Colors.green),
                        //   onPressed: () async {
                        //     makePhoneCall('880152122675');
                        //     // await FlutterPhoneDirectCaller.callNumber('+8801521226758');
                        //   },
                        // ),
                        // // More Options Button
                        // PopupMenuButton<String>(
                        //   onSelected: (value) {
                        //     if (value == 'edit') {
                        //       // Handle edit action
                        //       print('Edit action clicked');
                        //     } else if (value == 'delete') {
                        //       // Handle delete action
                        //       print('Delete action clicked');
                        //     }
                        //   },
                        //   itemBuilder: (BuildContext context) {
                        //     return {'Edit', 'Delete'}.map((String choice) {
                        //       return PopupMenuItem<String>(
                        //         value: choice.toLowerCase(),
                        //         child: Text(choice),
                        //       );
                        //     }).toList();
                        //   },
                        //   icon: const Icon(
                        //       Icons.more_vert, color: Colors.black54),
                        // ),
                      ],
                    ),

                    // 8.height, // Space between header and content
                    // divider(height: 1.h, width: Get.width),
                    // 8.height,
                    // // User contact details
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         const Icon(Icons.phone,
                    //             color: Colors.blueAccent, size: 18),
                    //         10.width,
                    //         AppTextStyle(
                    //           text: "01700000000",
                    //           fontSize: 14.sp,
                    //           color: Colors.black87,
                    //           fontWeight: FontWeight.w500,
                    //         )
                    //       ],
                    //     ),
                    //     8.height,
                    //     Row(
                    //       children: [
                    //         const Icon(Icons.location_on,
                    //             color: Colors.redAccent, size: 18),
                    //         10.width,
                    //         AppTextStyle(
                    //           text: "Dhaka",
                    //           fontSize: 14.sp,
                    //           color: Colors.black87,
                    //           fontWeight: FontWeight.w500,
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}

// Function to make phone call
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
  try {
    await launchUrl(phoneUri);
  } catch (error) {
    throw ("Cannot dial");
  }
}
