import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/groupdetail_screen/controller/groupdetails_controller.dart';
import 'package:sizer/sizer.dart';

class CreateRequestJoin extends GetView<GroupDetailController> {
  const CreateRequestJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Request to Join",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.clear)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Purpose.",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 30.h,
                width: 100.w,
                child: TextField(
                  controller: controller.purpose,
                  maxLines: 10,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: .2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(.5)),
                      hintText: 'State why you want to join in this group.',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 7.h,
        width: 100.w,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey, width: .5))),
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h, bottom: 1.h),
          child: InkWell(
            onTap: () {
              controller.createRequest();
            },
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
