import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/login_screen/controller/login_controller.dart';
import 'package:sgf/src/registration_screen/view/registration_view.dart';
import 'package:sizer/sizer.dart';

class LoginScreenView extends GetView<LoginController> {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: 40.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/loginlogonew.png"))),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            height: 7.h,
            width: 100.w,
            child: TextField(
              controller: controller.username,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 3.w),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Username'),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            height: 7.h,
            width: 100.w,
            child: TextField(
              controller: controller.password,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 3.w),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintText: 'Password'),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: InkWell(
              onTap: () {
                if (controller.username.text.isNotEmpty &&
                    controller.password.text.isNotEmpty) {
                  controller.login();
                }
              },
              child: Container(
                height: 7.h,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              children: [
                Text(
                  "Dont have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                InkWell(
                  onTap: () async {
                    Get.to(() => RegistrationScreenView());
                  },
                  child: Text(
                    "Sign up.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
