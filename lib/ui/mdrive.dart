import 'package:emmaus/constants.dart';
import 'package:emmaus/ui/drive_detail/drive_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MDrive extends StatelessWidget {
  const MDrive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.arrow_left)),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF073355),
                  child: Icon(
                    CupertinoIcons.person_solid,
                    color: Colors.white,
                  ),
                )
              ],
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
                                  Get.to(DriveDetail(
                                    title: "예배",
                                  ));
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
                                                          "images/folder.png"),
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
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    "3일전 업로드됨",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Nanum",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
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
                                  Get.to(() => DriveDetail(
                                        title: "광고",
                                      ));
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
                                                          "images/folder.png"),
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
                                                child: FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    "1일전 업로드됨",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Nanum",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
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
                            ),
                            Text(
                              "최근 7일이내 업로드 파일",
                              style: TextStyle(
                                  fontFamily: "Nanum",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10),
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container();
                                    }))
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
