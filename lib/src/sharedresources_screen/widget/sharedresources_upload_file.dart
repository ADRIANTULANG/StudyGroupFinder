import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/sharedresources_controller.dart';

class UploadSharedFile extends GetView<SharedResourcesController> {
  const UploadSharedFile({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<SharedResourcesController>() == false) {
      Get.put(SharedResourcesController());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Upload File",
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
                  "File",
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
                    controller.pickFile();
                  },
                  child: Container(
                    height: 15.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .55)),
                    alignment: Alignment.center,
                    child: Obx(
                      () => controller.filePath.value == ''
                          ? Icon(
                              Icons.folder_copy_outlined,
                              size: 50.sp,
                              color: Colors.grey,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_copy_rounded,
                                  size: 50.sp,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 3.w, right: 3.w),
                                    alignment: Alignment.center,
                                    width: 100.w,
                                    child: Obx(() => Text(
                                          controller.fileName.value,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 9.sp,
                                              overflow: TextOverflow.ellipsis),
                                        )))
                              ],
                            ),
                    ),
                  ),
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
                height: 30.h,
                width: 100.w,
                child: TextField(
                  controller: controller.description,
                  maxLines: 15,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 3.w, top: 2.h),
                      alignLabelWithHint: false,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: .2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(.5)),
                      hintText: "Description of the file?",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16.sp)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.isUploading.value == true
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
                      controller.uploadFile();
                    },
                    child: Container(
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        "Upload",
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
