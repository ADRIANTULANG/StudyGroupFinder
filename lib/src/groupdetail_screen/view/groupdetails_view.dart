import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/services/getstorage_services.dart';
import 'package:sgf/src/groupdetail_screen/controller/groupdetails_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../sharedresources_screen/view/sharedresources_view.dart';
import '../../sharedresources_screen/widget/sharedresources_upload_file.dart';
import '../widget/groupdetails_alertdialogs.dart';
import '../widget/groupdetails_create_post.dart';
import '../widget/groupdetails_join_group.dart';
import '../widget/groupdetails_view_request.dart';
import 'package:badges/badges.dart' as badge;

class GroupDetailsScreenView extends GetView<GroupDetailController> {
  const GroupDetailsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Group Page'),
        actions: [
          Obx(() => controller.isAdmin.value == true
              ? InkWell(
                  onTap: () {
                    Get.to(() => RequestView());
                  },
                  child: Obx(
                    () => badge.Badge(
                        showBadge:
                            controller.requestList.length == 0 ? false : true,
                        position: badge.BadgePosition.topEnd(top: .5.h),
                        stackFit: StackFit.passthrough,
                        badgeContent:
                            Text(controller.requestList.length.toString()),
                        child: Icon(Icons.people_alt)),
                  ))
              : SizedBox()),
          SizedBox(
            width: 4.w,
          ),
          Obx(
            () => controller.isAdmin.value == true
                ? InkWell(
                    onTap: () {
                      GroupDetailsAlertDialog.showDeleteMessage(
                          controller: controller);
                    },
                    child: Icon(Icons.delete))
                : SizedBox(),
          ),
          SizedBox(
            width: 5.w,
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(controller.group_image.value))),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          controller.group_name.value,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.sp),
                        )),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.isJoined.value == true) {
                                Get.to(() => ShredResourcesView(), arguments: {
                                  'group_id': controller.group_id.value,
                                  'group_name': controller.group_name.value
                                });
                              } else {
                                GroupDetailsAlertDialog.showRestrictionTwo();
                              }
                            },
                            child: Icon(Icons.folder)),
                        SizedBox(
                          width: 4.w,
                        ),
                        InkWell(
                            onTap: () {
                              if (controller.isJoined.value == true) {
                                Get.to(() => UploadSharedFile(), arguments: {
                                  'group_id': controller.group_id.value,
                                  'group_name': controller.group_name.value
                                });
                              } else {
                                GroupDetailsAlertDialog.showRestrictionTwo();
                              }
                            },
                            child: Icon(Icons.upload_file_rounded)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 9.sp,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Obx(
                      () => Text(
                        "${controller.membersCount.value} member/s",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 9.sp),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Obx(
                () => controller.isAdmin.value == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 9.sp,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              "You are an Administrator of this group.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 9.sp),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(
                      () => Text(
                        controller.group_description.value,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.sp),
                      ),
                    ),
                  )),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: InkWell(
                  onTap: () {
                    if (controller.isJoined.value == false) {
                      Get.to(() => CreateRequestJoin());
                    }
                  },
                  child: Obx(
                    () => Container(
                      height: 5.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: controller.isJoined.value == false
                              ? Colors.black
                              : Colors.grey),
                      child: Text(
                        controller.isJoined.value == false
                            ? "Request to join"
                            : "Joined",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 1.h,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Row(
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(Get.find<StorageServices>()
                                  .storage
                                  .read('image'))),
                          shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (controller.isJoined.value == true) {
                            controller.picked_image = null;
                            controller.imagePath.value = '';
                            controller.filename.value = '';
                            controller.uint8list = null;
                            Get.to(() => CreatePost());
                          } else {
                            GroupDetailsAlertDialog.showRestriction();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 3.w),
                          height: 5.h,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("Post something.."),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 1.h,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Post",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    )),
              ),
              SizedBox(
                height: 2.h,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                    .postList[index]
                                                    .userImage)),
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
                                            controller
                                                .postList[index].groupName,
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
                                      padding: EdgeInsets.only(
                                          top: 5.h, bottom: 5.h),
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
                                      DateFormat('jm').format(controller
                                          .postList[index].dateCreated),
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
      )),
    );
  }
}
