import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../services/getstorage_services.dart';
import '../../login_screen/view/login_view.dart';

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

  static showLogoutDialog() async {
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
            "Logout?",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: 3.5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  Get.find<StorageServices>().removeStorageCredentials();
                  Get.offAll(() => LoginScreenView());
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.green),
                ),
              )
            ],
          )
        ],
      ),
    )));
  }

  static showDeletePost(
      {required HomeController controller, required String documentID}) async {
    Get.dialog(AlertDialog(
        content: Container(
      height: 20.h,
      width: 100.w,
      color: Colors.white,
      child: Obx(
        () => controller.isDeleting.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delete Post",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Text(
                    "Do you want to delete this post?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 11.sp),
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          controller.deletePost(documentID: documentID);
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.red),
                        ),
                      )
                    ],
                  )
                ],
              ),
      ),
    )));
  }
}
