import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/services/getstorage_services.dart';
import 'package:sgf/services/notification_services.dart';
import 'package:sgf/src/home_screen/view/home_view.dart';
import 'package:intl/intl.dart';
import '../widget/login_screen_alertdialog.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  login() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    var res = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username.text)
        .where('password', isEqualTo: password.text)
        .limit(1)
        .get();

    if (res.docs.length > 0) {
      var userDetails = res.docs[0];

      var tok = await FirebaseFirestore.instance
          .collection('tokens')
          .where('userid', isEqualTo: userDetails.id)
          .limit(1)
          .get();

      var deviceIDandTokens = tok.docs;
      String deviceID = '';

      if (deviceIDandTokens.length > 0) {
        deviceID = deviceIDandTokens[0]['deviceid'];
      }
      if (deviceIDandTokens.length == 0 || deviceID == androidDeviceInfo.id) {
        var profileImage = userDetails['image'];
        if (userDetails['image'] == '') {
          profileImage =
              'https://firebasestorage.googleapis.com/v0/b/studygroupfinder-1c13d.appspot.com/o/files%2Fvectorprofile.png?alt=media&token=c53b7efa-6553-49aa-a988-aaee9062527b';
        }
        Get.find<StorageServices>().saveCredentials(
          id: userDetails.id,
          username: userDetails['username'],
          password: userDetails['password'],
          firstname: userDetails['firstname'],
          lastname: userDetails['lastname'],
          image: profileImage,
          address: userDetails['address'],
          contactno: userDetails['contact'],
        );
        Get.offAll(() => HomeScreenView());
      } else {
        LoginAlertDialog.showLoginExist(
            devicename: deviceIDandTokens[0]['deviceName']);
        Get.find<NotificationServices>().sendNotification(
            userToken: deviceIDandTokens[0]['token'],
            deviceName: androidDeviceInfo.brand + " " + androidDeviceInfo.model,
            time: DateFormat('yMMMd').format(DateTime.now()) +
                " " +
                DateFormat('jm').format(DateTime.now()));
      }
    } else {
      LoginAlertDialog.showAccountNotFound();
    }
  }
}
