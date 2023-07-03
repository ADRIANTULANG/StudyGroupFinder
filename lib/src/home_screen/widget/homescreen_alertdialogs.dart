import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomescreenAlertDialog {
  static showSuccessCreateGroup() async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Success!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "Group successfully created.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.sp),
          ),
        ],
      ),
    )));
  }
}
