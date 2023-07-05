import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sgf/src/groupdetail_screen/controller/groupdetails_controller.dart';
import 'package:sizer/sizer.dart';

class CreatePost extends GetView<GroupDetailController> {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Create Post",
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
                  "Message or Announcement",
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
                  controller: controller.posttext,
                  maxLines: 5,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: .2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(.5)),
                      hintText: "What's on your mind?",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16.sp)),
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
                  "Image",
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
                    height: 35.h,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.isPosting.value == true
            ? Container(
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: .5))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 1.h, bottom: 1.h),
                  child: Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 25.sp,
                      )),
                ),
              )
            : Container(
                height: 7.h,
                width: 100.w,
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: .5))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 1.h, bottom: 1.h),
                  child: InkWell(
                    onTap: () {
                      controller.createPost();
                    },
                    child: Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
