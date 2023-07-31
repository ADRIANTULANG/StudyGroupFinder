import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../services/notification_services.dart';
import '../../login_screen/widget/login_screen_alertdialog.dart';

class OtpScreenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString firstname = ''.obs;
  RxString lastname = ''.obs;
  RxString address = ''.obs;
  RxString password = ''.obs;
  RxString username = ''.obs;

  RxString contact = ''.obs;
  RxString verifIDReceived = ''.obs;

  RxBool isVerifyingOTP = false.obs;
  @override
  void onInit() async {
    firstname.value = await Get.arguments['firstname'];
    lastname.value = await Get.arguments['lastname'];
    address.value = await Get.arguments['address'];
    password.value = await Get.arguments['password'];
    username.value = await Get.arguments['username'];
    contact.value = await Get.arguments['contact'];
    verifIDReceived.value = await Get.arguments['verifIDReceived'];

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, context) async {
    try {
      isVerifyingOTP(true);
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        try {
          var res = await FirebaseFirestore.instance.collection("users").add({
            "address": address.value,
            "image": "",
            "contact": contact.value,
            "firstname": firstname.value,
            "lastname": lastname.value,
            "password": password.value,
            "username": username.value,
          });
          getDeviceId(id: res.id);
          Get.back();
          Get.back();
          LoginAlertDialog.showSuccessCreateAccount();
        } on Exception catch (e) {
          print("something went wrong $e");
        }
      }
      isVerifyingOTP(false);
    } on FirebaseAuthException catch (e) {
      print(e);
      isVerifyingOTP(false);
    }
  }

  getDeviceId({required String id}) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print(androidDeviceInfo.model);
      print(androidDeviceInfo.product);
      print(androidDeviceInfo.brand);
      print(androidDeviceInfo.id);
      String token = await Get.find<NotificationServices>().getToken();
      await FirebaseFirestore.instance.collection('tokens').add({
        "token": token,
        "deviceid": androidDeviceInfo.id,
        "userid": id,
        "deviceName": androidDeviceInfo.brand + " " + androidDeviceInfo.model
      });
    }
  }
}
