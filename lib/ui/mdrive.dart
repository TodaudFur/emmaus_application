import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controller/drive_controller.dart';
import '../controller/drive_home_controller.dart';

class MDrive extends StatelessWidget {
  MDrive({Key? key}) : super(key: key);

  final driveHomeController = Get.put(DriveHomeController());

  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey.shade100, width: 1),
          ),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 18, color: Colors.black87),
            child: IntrinsicWidth(
              child: driveHomeController.isLogin
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "이름 : ${driveHomeController.userModel.name}",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nanum",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${driveHomeController.userModel.term}기",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nanum",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "로그인이 필요합니다",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nanum",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          color: kSelectColor,
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () {
                            Get.toNamed("/");
                          },
                          child: Text(
                            "로그인",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    print(driveHomeController.userModel.name);
    print(driveHomeController.userModel.id);
    driveHomeController.getRecentFile();
    driveHomeController.getRecentFile7Days();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    showAlignedDialog(
                        context: context,
                        builder: _localDialogBuilder,
                        followerAnchor: Alignment.topRight,
                        targetAnchor: Alignment.bottomLeft,
                        barrierColor: Colors.transparent);
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF073355),
                    child: Icon(
                      CupertinoIcons.person_solid,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400]!.withOpacity(0.3),
                                spreadRadius: 0.5,
                                blurRadius: 15,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: kBodyColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  if (driveHomeController.isLogin) {
                                    Get.toNamed('/worship');
                                  } else {
                                    Get.toNamed('/');
                                  }
                                },
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 15,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: const Color(0xFF1A4073),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Container()),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Image.asset(
                                                        "images/folder.png",
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                  ],
                                                )),
                                                Expanded(
                                                  child: Container(),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: Container()),
                                            const Expanded(
                                                flex: 9,
                                                child: Text(
                                                  "예배",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nanum",
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                )),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1, child: Container()),
                                            Expanded(
                                                flex: 4,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(() => FittedBox(
                                                        fit: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                500
                                                            ? BoxFit.none
                                                            : BoxFit.fitHeight,
                                                        child: Text(
                                                          driveHomeController
                                                              .getUpload(
                                                                  "worship"),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Nanum",
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    500
                                                                ? 12
                                                                : null,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      )),
                                                )),
                                            Expanded(
                                                flex: 4, child: Container()),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  if (driveHomeController.isLogin) {
                                    Get.toNamed("/driveDetail",
                                        arguments: "광고");
                                  } else {
                                    Get.toNamed('/');
                                  }
                                },
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEBB144),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Container()),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Image.asset(
                                                        "images/folder.png",
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                  ],
                                                )),
                                                Expanded(
                                                  child: Container(),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: Container()),
                                            const Expanded(
                                                flex: 9,
                                                child: Text(
                                                  "광고",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nanum",
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                )),
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Expanded(
                                                flex: 1, child: Container()),
                                            Expanded(
                                                flex: 4,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Obx(() => FittedBox(
                                                        fit: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width >
                                                                500
                                                            ? BoxFit.none
                                                            : BoxFit.fitHeight,
                                                        child: Text(
                                                          driveHomeController
                                                              .getUpload("ad"),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "Nanum",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width >
                                                                    500
                                                                ? 12
                                                                : null,
                                                          ),
                                                        ),
                                                      )),
                                                )),
                                            Expanded(
                                                flex: 4, child: Container()),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                              width: Get.width,
                            ),
                            Text(
                              "최근 7일이내 업로드 파일",
                              style: TextStyle(
                                  fontFamily: "Nanum",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                                child: Obx(() => driveHomeController
                                        .recentFiles.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: driveHomeController
                                            .recentFiles.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              final driveController =
                                                  Get.put(DriveController());
                                              driveController.downloadFile(
                                                  "https://official-emmaus.com/g5/bbs/drive/${driveHomeController.recentFiles[index].totalDirectory}/${driveHomeController.recentFiles[index].fileName}.${driveHomeController.recentFiles[index].fileType}");
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding: const EdgeInsets.only(
                                                  top: 9, bottom: 9, left: 10),
                                              color: Colors.white,
                                              height: 30,
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  FittedBox(
                                                    child: driveHomeController
                                                        .getFileImage(
                                                            driveHomeController
                                                                .recentFiles[
                                                                    index]
                                                                .fileType),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      driveHomeController
                                                          .recentFiles[index]
                                                          .fileName,
                                                      style: const TextStyle(
                                                        fontFamily: "Nanum",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                    : Text("최근에 업로드된 파일이 없습니")))
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
