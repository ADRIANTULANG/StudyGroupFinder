import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/groupdetail_screen/controller/groupdetails_controller.dart';
import 'package:sizer/sizer.dart';

class RequestView extends GetView<GroupDetailController> {
  const RequestView({super.key});

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
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.requestList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 5.h,
                              width: 5.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(controller
                                          .requestList[index].userImage)),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.requestList[index].userName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              controller.acceptOrDeclineRequest(
                                  isApproved: false,
                                  requestDetails:
                                      controller.requestList[index]);
                            },
                            child: Icon(Icons.clear))
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      child: Text(
                        controller.requestList[index].purpose,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 1.h,
                    ),
                    InkWell(
                      onTap: () {
                        controller.acceptOrDeclineRequest(
                            isApproved: true,
                            requestDetails: controller.requestList[index]);
                      },
                      child: Container(
                        height: 5.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.green),
                        alignment: Alignment.center,
                        child: Text(
                          "Accept Request",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
