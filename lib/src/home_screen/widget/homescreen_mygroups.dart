import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../groupdetail_screen/view/groupdetails_view.dart';

class MyGroupsScreenView extends GetView<HomeController> {
  const MyGroupsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5.w, left: 5.w),
      child: Obx(
        () => ListView.builder(
          itemCount: controller.mygroupsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => GroupDetailsScreenView(), arguments: {
                        "group_id": controller.mygroupsList[index].id,
                        "group_name": controller.mygroupsList[index].name,
                        "group_description":
                            controller.mygroupsList[index].description,
                        "group_image": controller.mygroupsList[index].image,
                      });
                    },
                    child: Container(
                      height: 30.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  controller.mygroupsList[index].image))),
                    ),
                  ),
                  Positioned(
                    bottom: 1.5.h,
                    child: Container(
                        padding: EdgeInsets.only(
                          left: 2.w,
                        ),
                        width: 100.w,
                        child: Stack(
                          children: [
                            Text(
                              controller.mygroupsList[index].name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.black,
                              ),
                            ),
                            Text(
                              controller.mygroupsList[index].name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
