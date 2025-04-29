import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:shop_villa_seller/global/log_printer.dart';
import '../../../../../global/global_snackbar.dart';
import '../../../../../helper/exception_handle.dart';
import '../../../../../helper/helper_utils.dart';
import '../../../../repository/api_services.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/local_store_config.dart';

class LoginController extends GetxController {
  // Loading button
  RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  // Is remember me
  RxBool boxCheck = true.obs;
  // Password visibility
  RxBool hidePassword = true.obs;
  // Text Field Controller
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  var emailError = ''.obs;
  var passwordError = ''.obs;

  ///Auth
  final ApiServices apiService = ApiServices();

  /// Login
  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await apiService.loginUser(email, password);
      if (response.status == true) {
        // Delete Existing token set new token for login
        HiveService.deleteToken();
        HiveService.setToken(response.data!.token!);
        // Delete Existing AdminID set new token for login
        HiveService.deleteAdminID();
        HiveService.setAdminID(response.data!.admin!.uniqueId!);
        // Set the Token and UserID in local storage
        HelperUtils.token = (await HiveService.getToken())!;
        HelperUtils.adminID = (await HiveService.getAdminID())!;
        // Set the Admin is Authenticate or Unauthenticated
        await HiveService.checkLoginStatus();
        await HelperUtils.initializeMainControllers();
        btnController.stop();
        Get.offAllNamed(Routes.MAIN_PAGE);
        globalSnackBar(
            title: "Login!",
            message: response.message![0].toString(),
            durationInSeconds: 2);
        /// Retrieve the Device Token
        final deviceToken = HelperUtils.firebaseToken;
        final adminDocRef = FirebaseFirestore.instance.collection('users').doc(HelperUtils.adminID);
        final adminDoc = await adminDocRef.get();
        if (adminDoc.exists) {
          final existingDeviceToken = adminDoc.data()?['device_token'];
          if (existingDeviceToken != deviceToken) {
            // Update the Firestore document with the new device token
            await adminDocRef.update({
              'device_token': deviceToken,
            });
            Log.i('Device token updated in Firestore.');
          } else {
            Log.i('Device token is the same, no update required.');
          }
        } else {
          await adminDocRef.set({
            'email': response.data!.admin!.email!,
            'name': response.data!.admin!.name,
            'id': response.data!.admin!.id,
            'unique_id': response.data!.admin!.uniqueId,
            'device_token': deviceToken,
          });
          Log.i('New admin document created in Firestore.');
        }

      } else {
        globalSnackBar(
            title: "Unsuccessful Login!",
            message: response.message![0].toString(),
            durationInSeconds: 2);
        btnController.stop();
      }
    } catch (e) {
      handleException(e);
      btnController.stop();
    }
  }



  //Login Validation
  bool validateInputs() {
    bool isValid = true;
    if (emailEditingController.text.isEmpty) {
      emailError.value = '* Required';
      isValid = false;
    } else if (!GetUtils.isEmail(emailEditingController.text)) {
      emailError.value = 'Enter a valid email';
      isValid = false;
    } else {
      emailError.value = '';
    }
    if (passEditingController.text.isEmpty) {
      passwordError.value = '* Required';
      isValid = false;
    } else {
      passwordError.value = '';
    }
    return isValid;
  }

  /// Google Sign In
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final socialName = "User".obs;
  // final Rx<User?> user = Rx<User?>(null);
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     if (googleSignInAccount == null) {
  //       debugPrint('Error getting Google sign-in account');
  //       return;
  //     }
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     final UserCredential userCredential = await auth.signInWithCredential(credential);
  //     user.value = userCredential.user;
  //     if (user.value != null) {
  //       final String? email = user.value!.email;
  //       // Retrieve UserInfo from providerData
  //       final UserInfo? userInfo = user.value!.providerData.isNotEmpty
  //           ? user.value!.providerData[0] // Access the first UserInfo
  //           : null;
  //       final String password = user.value!.uid; // Using UID as password for consistency
  //       try {
  //         await loginUser(email: email!, password: password);
  //       } catch (loginError) {
  //         handleException(loginError);
  //       }
  //     } else {
  //       // Sign out if already signed in
  //       await auth.signOut();
  //       user.value = null;
  //     }
  //   } catch (e) {
  //     handleException(e);
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    emailEditingController.dispose();
    passEditingController.dispose();
    super.dispose();
  }
}

