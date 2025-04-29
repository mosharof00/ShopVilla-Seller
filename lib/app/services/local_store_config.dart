import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:shop_villa_seller/global/log_printer.dart';

import '../../helper/helper_utils.dart';

class HiveService {
  static var box;
  static var searchHistory;

  static initHive() async {
    var dir = await pathprovider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('appData');
    searchHistory = await Hive.openBox('searchHistory');
  }

  static setAdminID(String id) {
    box.put('id', id);
  }

  static deleteAdminID() {
    box.delete('id');
  }

  static Future<String?> getAdminID() async {
    return await box.get('id') ?? '0';
  }

  static setToken(String token) {
    box.put('token', token);
  }

  static deleteToken() {
    box.delete('token');
  }

  static Future<String?> getToken() async {
    return await box.get('token') ?? "";
  }

  static setFirebaseToken(String firebaseToken) {
    box.put('firebaseToken', firebaseToken);
  }

  static deleteFirebaseToken() {
    box.delete('firebaseToken');
  }

  static Future<String?> getFirebaseToken() async {
    return await box.get('firebaseToken');
  }



  static checkLoginStatus() async {
    String? id = await HiveService.getAdminID();
    String? token =await HiveService.getToken();
    // Log.w('ID : $id');
    // Log.w('Token : $token');
    if (id != null && token != null && token.isNotEmpty) {
      HelperUtils.isLogin = true;
    } else {
      HelperUtils.isLogin = false;
    }
  }

  static setLanguage(String language) {
    box.put('language', language);
  }

  static getLanguage() {
    return box.get('language', defaultValue: 'en_en');
  }
}
