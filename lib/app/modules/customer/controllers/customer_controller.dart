import 'package:get/get.dart';
import 'package:shop_villa_seller/app/repository/api_services.dart';
import 'package:shop_villa_seller/helper/exception_handle.dart';

class CustomerController extends GetxController {
  final apiService = ApiServices();
  final customerList = [].obs;
  final isLoading = false.obs;

  Future<void> getCustomers() async {
    try{
    isLoading.value = true;
      final response = await apiService.getCustomers();
      customerList.value = response.data!;
       isLoading.value = false;
    } catch(e){
      handleException(e);
       isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getCustomers();
    super.onInit();
  }

}
