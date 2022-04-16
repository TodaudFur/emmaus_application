import 'package:emmaus/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import '../../controller/drive_controller.dart';

class DriveDetail extends StatelessWidget {
  DriveDetail({Key? key, required this.title}) : super(key: key);
  final driveController = Get.put(DriveController());
  final String title;
  @override
  Widget build(BuildContext context) {
    driveController.getDriveList(title);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(CupertinoIcons.arrow_left)),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: "Nanum",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.search)),
                    PopupMenuButton(
                      padding: const EdgeInsets.all(1),
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                            height: 30,
                            child: Text(
                              "링크공유",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        const PopupMenuItem(
                            height: 30,
                            child: Text(
                              "이름바꾸기",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        const PopupMenuItem(
                            height: 30,
                            child: Text(
                              "삭제",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 17),
                child: Obx(() => driveController.isLoading
                    ? driveController.driveList.isNotEmpty
                        ? ListView.builder(
                            itemCount: driveController.driveList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  print(driveController
                                      .driveList[index].fileName);
                                  driveController.getDriveList(driveController
                                      .driveList[index].fileName);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 9, left: 10),
                                  color: Colors.white,
                                  height: 30,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      FittedBox(
                                        child: driveController.getFileImage(
                                            driveController
                                                .driveList[index].fileType),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          driveController
                                              .driveList[index].fileName,
                                          style: const TextStyle(
                                            fontFamily: "Nanum",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Text("파일이 없습니다")
                    : const Center(
                        child: CircularProgressIndicator(),
                      )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: kSelectColor,
        child: Center(
          child: Image.asset(
            "images/logo_em_3.png",
            scale: 6.0,
          ),
        ),
        overlayColor: Colors.black,
        overlayOpacity: 0.1,
        spacing: 10,
        spaceBetweenChildren: 5,
        activeChild: const Icon(CupertinoIcons.xmark),
        children: [
          SpeedDialChild(
            onTap: () {
              driveController.cameraSave(title);
            },
            child: const Icon(CupertinoIcons.photo_camera_solid),
            backgroundColor: const Color(0xFF1A4073),
            foregroundColor: Colors.white,
            label: '카메라',
          ),
          SpeedDialChild(
              child: const Icon(CupertinoIcons.square_arrow_up),
              backgroundColor: const Color(0xFF1A4073),
              foregroundColor: Colors.white,
              label: '업로드',
              onTap: () {
                driveController.fileSave(title);
              }),
          SpeedDialChild(
            child: const Icon(CupertinoIcons.folder_solid),
            backgroundColor: const Color(0xFF1A4073),
            foregroundColor: Colors.white,
            label: '폴더',
            onTap: () {
              driveController.folderSave(title);
            },
          ),
        ],
      ),
    );
  }
}
