import 'dart:async';

import 'package:get/get.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';

import '../../home_screen/model/home_groups_model.dart';

class SearchController extends GetxController {
  String word = '';

  RxList<Groups> groupsList = <Groups>[].obs;
  RxList<Groups> groupsList_MasterList = <Groups>[].obs;

  Timer? debounce;

  @override
  void onInit() async {
    groupsList.assignAll(Get.find<HomeController>().groupsList);
    groupsList_MasterList.assignAll(Get.find<HomeController>().groupsList);
    word = await Get.arguments['word'];
    searchGroup(keyword: word);
    super.onInit();
  }

  searchGroup({required String keyword}) async {
    groupsList.clear();
    for (var i = 0; i < groupsList_MasterList.length; i++) {
      if (groupsList_MasterList[i]
          .name
          .toLowerCase()
          .toString()
          .contains(keyword)) {
        groupsList.add(groupsList_MasterList[i]);
      }
    }
  }
}
