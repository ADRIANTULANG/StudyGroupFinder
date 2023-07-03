import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sgf/src/registration_screen/controller/registration_controller.dart';
import 'package:sizer/sizer.dart';

class RegistrationScreenView extends GetView<RegistrationController> {
  const RegistrationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
    return WillPopScope(
      onWillPop: () => controller.getBack(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isVerifyingNumber.value == true
              ? Container(
                  height: 100.h,
                  width: 100.w,
                  color: Colors.white,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  )),
                )
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.sp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/loginlogonew.png"))),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Obx(
                          () => controller.toInput.value == 0
                              ? Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w),
                                      height: 7.h,
                                      width: 100.w,
                                      child: TextField(
                                        controller: controller.firstname,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.only(left: 3.w),
                                            alignLabelWithHint: false,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            hintText: 'first name'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 5.w, right: 5.w),
                                      height: 7.h,
                                      width: 100.w,
                                      child: TextField(
                                        controller: controller.lastname,
                                        decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.only(left: 3.w),
                                            alignLabelWithHint: false,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            hintText: 'last name'),
                                      ),
                                    ),
                                  ],
                                )
                              : controller.toInput.value == 1
                                  ? Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          height: 7.h,
                                          width: 100.w,
                                          child: TextField(
                                            controller: controller.address,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.only(left: 3.w),
                                                alignLabelWithHint: false,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                hintText: 'Address'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          height: 7.h,
                                          width: 100.w,
                                          child: TextField(
                                            controller: controller.contact,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {
                                              if (controller
                                                      .contact.text.length ==
                                                  0) {
                                              } else {
                                                if (controller
                                                            .contact.text[0] !=
                                                        "9" ||
                                                    controller.contact.text
                                                            .length >
                                                        10) {
                                                  controller.contact.clear();
                                                } else {}
                                              }
                                            },
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.only(left: 3.w),
                                                alignLabelWithHint: false,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                hintText: 'Contact no'),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          height: 7.h,
                                          width: 100.w,
                                          child: TextField(
                                            controller: controller.username,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.only(left: 3.w),
                                                alignLabelWithHint: false,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                hintText: 'Username'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          height: 7.h,
                                          width: 100.w,
                                          child: TextField(
                                            controller: controller.password,
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.only(left: 3.w),
                                                alignLabelWithHint: false,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                hintText: 'Password'),
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: InkWell(
                            onTap: () {
                              if (controller.toInput.value == 0) {
                                if (controller.firstname.text.isNotEmpty &&
                                    controller.lastname.text.isNotEmpty) {
                                  controller.toInput.value++;
                                }
                              } else if (controller.toInput.value == 1) {
                                if (controller.address.text.isNotEmpty &&
                                    controller.contact.text.isNotEmpty &&
                                    controller.contact.text.length == 10) {
                                  controller.toInput.value++;
                                }
                              } else if (controller.toInput.value == 2) {
                                if (controller.address.text.isNotEmpty &&
                                    controller.contact.text.isNotEmpty) {
                                  controller.verifiyNumber();
                                }
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
                                "NEXT",
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
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: controller.toInput.value == 0
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Obx(
                              () => Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: controller.toInput.value == 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Obx(
                              () => Icon(
                                Icons.circle,
                                size: 10.sp,
                                color: controller.toInput.value == 2
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
