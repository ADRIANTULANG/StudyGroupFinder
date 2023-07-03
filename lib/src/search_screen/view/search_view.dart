import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgf/src/search_screen/controller/search_controller.dart';
import 'package:sizer/sizer.dart';

import '../../groupdetail_screen/view/groupdetails_view.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 5.h,
          width: 70.w,
          child: TextField(
            onChanged: (value) {
              if (controller.debounce?.isActive ?? false)
                controller.debounce!.cancel();
              controller.debounce =
                  Timer(const Duration(milliseconds: 1000), () {
                if (value.isEmpty || value == "") {
                  controller.groupsList
                      .assignAll(controller.groupsList_MasterList);
                } else {
                  controller.searchGroup(keyword: value);
                }
                FocusScope.of(context).unfocus();
              });
            },
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.only(left: 3.w),
                alignLabelWithHint: false,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Search'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.groupsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => GroupDetailsScreenView(), arguments: {
                          "group_id": controller.groupsList[index].id,
                          "group_name": controller.groupsList[index].name,
                          "group_description":
                              controller.groupsList[index].description,
                          "group_image": controller.groupsList[index].image,
                        });
                      },
                      child: Container(
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    controller.groupsList[index].image))),
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
                                controller.groupsList[index].name,
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
                                controller.groupsList[index].name,
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
      ),
    );
  }
}
