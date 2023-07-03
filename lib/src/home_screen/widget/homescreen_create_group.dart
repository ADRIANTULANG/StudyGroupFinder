import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

class CreateGroup extends GetView<HomeController> {
  const CreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Create Group",
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
                  "Name",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
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
                  controller: controller.groupname,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Name your group',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.sp)),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Group Image",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: InkWell(
                  onTap: () {
                    controller.getImage();
                  },
                  child: Container(
                    height: 25.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .55)),
                    child: Obx(
                      () => controller.imagePath.value == ''
                          ? Icon(
                              Icons.image,
                              size: 25.sp,
                              color: Colors.grey,
                            )
                          : Image.file(
                              controller.picked_image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Description",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                height: 15.h,
                width: 100.w,
                child: TextField(
                  controller: controller.groupdescription,
                  maxLines: 5,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: .2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(.5)),
                      hintText: 'Describe your group',
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
              controller.createGroup();
            },
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: Text(
                "Create Group",
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
