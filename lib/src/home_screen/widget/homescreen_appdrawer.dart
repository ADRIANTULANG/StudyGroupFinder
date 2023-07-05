import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../profile_screen/view/profile_view.dart';
import '../controller/home_controller.dart';
import 'homescreen_alertdialogs.dart';

class HomeScreenAppDrawer {
  static showAppDrawer({required HomeController controller}) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
              height: 15.h,
              width: 100.w,
              child: Image.asset("assets/images/loginlogonew.png")),
          SizedBox(
            height: 3.h,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Get.to(() => ProfileView());
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              HomescreenAlertDialog.showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }
}
