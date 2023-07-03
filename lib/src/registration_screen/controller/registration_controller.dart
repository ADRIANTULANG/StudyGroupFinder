import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../otp_screen/view/otp_screen_view.dart';

class RegistrationController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController contact = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String verifIDReceived = "";

  RxBool isVerifyingNumber = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  RxInt toInput = 0.obs;

  getBack() async {
    if (toInput.value == 0) {
      Get.back();
    } else {
      toInput.value--;
    }
  }

  verifiyNumber() async {
    isVerifyingNumber(true);
    await auth.verifyPhoneNumber(
        // phoneNumber: "09367325510",
        phoneNumber: "+63${contact.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {});
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
          isVerifyingNumber(false);
        },
        codeSent: (String verificationID, int? resendToken) {
          verifIDReceived = verificationID;

          Get.to(() => OtpScreenView(), arguments: {
            "firstname": firstname.text,
            "lastname": lastname.text,
            "address": address.text,
            "password": password.text,
            "username": username.text,
            "contact": contact.text,
            "verifIDReceived": verifIDReceived
          });
          isVerifyingNumber(false);
        },
        codeAutoRetrievalTimeout: (String verificationID) {},
        timeout: Duration(seconds: 60));
  }
}
