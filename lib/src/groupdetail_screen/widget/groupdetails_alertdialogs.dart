import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class GroupDetailsAlertDialog {
  static showRestriction() async {
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
            "Message",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "Join the group in order to post message or announcement. Thank you",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.sp),
          ),
        ],
      ),
    )));
  }

  static showRestrictionTwo() async {
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
            "Message",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "Join the group in order to upload files and share it to the group. Thank you",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.sp),
          ),
        ],
      ),
    )));
  }

  static showSuccessRequest() async {
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
            "Message",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Text(
            "The Admin of this group will check your request and will decide to accept your request.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11.sp),
          ),
        ],
      ),
    )));
  }
}
