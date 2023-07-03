import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/home_controller.dart';
import '../widget/homescreen_appdrawer.dart';
import '../widget/homescreen_create_group.dart';

class HomeScreenView extends GetView<HomeController> {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: HomeScreenAppDrawer.showAppDrawer(controller: controller),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
              FocusScope.of(context).unfocus();
            },
            child: Icon(
              Icons.person_2,
              size: 30.sp,
              color: Colors.white,
            ),
          );
        }),
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
                } else {
                  // Get.to(() => SearchScreenView(),
                  //     arguments: {"keyword": value});
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
      body: Obx(() => controller.screens[controller.pageindex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.pageindex.value,
            onTap: (index) {
              controller.pageindex.value = index;
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Groups"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.group), label: "My Groups"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          controller.picked_image = null;
          controller.imagePath.value = '';
          controller.filename.value = '';
          controller.uint8list = null;
          Get.to(() => CreateGroup());
        },
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: .5.h),
              color: Colors.black,
              shape: BoxShape.circle),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
