import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class WorshipDetail extends StatelessWidget {
  const WorshipDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBodyColor,
        foregroundColor: Colors.black54,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: kBodyColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: InkWell(
                onTap: () {
                  Get.toNamed("/driveDetail", arguments: "주일 예배");
                },
                child: Container(
                  height: 150,
                  constraints: const BoxConstraints(maxWidth: 550),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A4073),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "images/folder.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "주일 예배",
                              style: TextStyle(
                                color: Color(0xFF1A4073),
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "주일 예배 자료를 올려주세요.",
                              style: TextStyle(
                                color: Color(0xFF1A4073),
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: InkWell(
                onTap: () {
                  Get.toNamed("/driveDetail", arguments: "금요철야 예배");
                },
                child: Container(
                  height: 150,
                  constraints: const BoxConstraints(maxWidth: 550),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBB144),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "images/folder.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "금요철야 예배",
                              style: TextStyle(
                                color: Color(0xFF1A4073),
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "금요철야 예배 자료를 올려주세요.",
                              style: TextStyle(
                                color: Color(0xFF1A4073),
                                fontFamily: "Nanum",
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
