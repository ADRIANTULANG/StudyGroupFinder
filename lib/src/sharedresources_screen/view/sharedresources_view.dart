import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../controller/sharedresources_controller.dart';
import '../widget/sharedresources_upload_file.dart';

class ShredResourcesView extends GetView<SharedResourcesController> {
  const ShredResourcesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SharedResourcesController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Shared Resources"),
        actions: [
          InkWell(
              onTap: () {
                controller.filePath.value = '';
                controller.fileName.value = '';
                controller.fileType.value = '';
                controller.pickedFile = null;
                controller.description.clear();
                controller.uint8list = null;
                Get.to(() => UploadSharedFile());
              },
              child: Icon(Icons.file_upload_rounded)),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      // 'png',
      // 'jpg',
      // 'svg',
      // 'jpeg',
      // 'gif',
      body: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: Obx(
          () => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2.w),
            itemCount: controller.fileList.length,
            itemBuilder: (BuildContext context, int index) {
              return controller.fileList[index].filetype == 'png' ||
                      controller.fileList[index].filetype == 'jpg' ||
                      controller.fileList[index].filetype == 'svg' ||
                      controller.fileList[index].filetype == 'jpeg' ||
                      controller.fileList[index].filetype == 'gif'
                  ? Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 17.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: Colors.grey, width: .5),
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(controller
                                          .fileList[index].fileLink))),
                            ),
                            Positioned(
                              child: Obx(
                                () => controller.fileList[index].isDownloading
                                            .value ==
                                        false
                                    ? SizedBox()
                                    : Obx(
                                        () => CircularPercentIndicator(
                                          radius: 8.w,
                                          lineWidth: 1.w,
                                          animation: true,
                                          percent: controller
                                              .fileList[index].progress.value,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: Colors.green,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.fileList[index].filename,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 9.sp),
                              ),
                            ),
                            Obx(() => controller
                                        .fileList[index].isDownloading.value ==
                                    true
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller.downloadFile(
                                          filename: controller
                                              .fileList[index].filename,
                                          index: index,
                                          link: controller
                                              .fileList[index].fileLink);
                                    },
                                    child: Icon(Icons.download_rounded)))
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              height: 17.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(color: Colors.grey, width: .5),
                                  color: Colors.grey[200]),
                              child: Icon(
                                Icons.file_copy,
                                color: Colors.brown[300],
                                size: 30.sp,
                              ),
                            ),
                            Positioned(
                              child: Obx(
                                () => controller.fileList[index].isDownloading
                                            .value ==
                                        false
                                    ? SizedBox()
                                    : Obx(
                                        () => CircularPercentIndicator(
                                          radius: 8.w,
                                          lineWidth: 1.w,
                                          animation: true,
                                          percent: controller
                                              .fileList[index].progress.value,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: Colors.green,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.fileList[index].filename,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 9.sp),
                              ),
                            ),
                            Obx(() => controller
                                        .fileList[index].isDownloading.value ==
                                    true
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      controller.downloadFile(
                                          filename: controller
                                              .fileList[index].filename,
                                          index: index,
                                          link: controller
                                              .fileList[index].fileLink);
                                    },
                                    child: Icon(Icons.download_rounded)))
                          ],
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
