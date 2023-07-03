import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/groupdetail_screen/view/groupdetails_view.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class GroupsScreenView extends GetView<HomeController> {
  const GroupsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Groups",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              width: 100.w,
              height: 18.h,
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.groupsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => GroupDetailsScreenView(),
                                  arguments: {
                                    "group_id": controller.groupsList[index].id,
                                    "group_name":
                                        controller.groupsList[index].name,
                                    "group_description": controller
                                        .groupsList[index].description,
                                    "group_image":
                                        controller.groupsList[index].image,
                                  });
                            },
                            child: Container(
                              height: 17.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          controller.groupsList[index].image),
                                      colorFilter: ColorFilter.mode(
                                        Colors.white.withOpacity(0.7),
                                        BlendMode.modulate,
                                      )),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          Positioned(
                            bottom: 1.5.h,
                            child: Container(
                                padding: EdgeInsets.only(
                                  left: 2.w,
                                ),
                                width: 35.w,
                                child: Stack(
                                  children: [
                                    Text(
                                      controller.groupsList[index].name,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1
                                          ..color = Colors.black,
                                      ),
                                    ),
                                    Text(
                                      controller.groupsList[index].name,
                                      style: TextStyle(
                                        fontSize: 10.sp,
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
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              height: 1.h,
              width: 100.w,
              color: Colors.black12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Post",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  )),
            ),
            Container(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 1.h, bottom: 1.h, left: 5.w, right: 5.w),
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
                                                  .postList[index].userImage)),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.postList[index].userName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp),
                                        ),
                                        Text(
                                          controller.postList[index].groupName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 9.sp),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.postList.removeWhere(
                                          (element) =>
                                              element.id ==
                                              controller.postList[index].id);
                                    },
                                    icon: Icon(Icons.clear_rounded))
                              ],
                            ),
                            controller.postList[index].post == ""
                                ? SizedBox()
                                : Container(
                                    width: 100.w,
                                    padding:
                                        EdgeInsets.only(top: 5.h, bottom: 5.h),
                                    child: Text(
                                      controller.postList[index].post,
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  ),
                            controller.postList[index].image == ""
                                ? SizedBox()
                                : Container(
                                    height: 30.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            image: NetworkImage(controller
                                                .postList[index].image))),
                                  ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat('yMMMd').format(controller
                                        .postList[index].dateCreated) +
                                    " " +
                                    DateFormat('jm').format(
                                        controller.postList[index].dateCreated),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 9.sp),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
