import 'package:emmaus/constants.dart';
import 'package:emmaus/contents.dart';
import 'package:emmaus/game.dart';
import 'package:emmaus/qtall.dart';
import 'package:emmaus/ui/summer_fre/summer_fre.dart';
import 'package:emmaus/vardata.dart';
import 'package:emmaus/winter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'emmaus.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '안녕하세요 ',
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    VarData().getName(),
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '님',
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(),
                        ),
                      ],
                    ),
                    VarData().getSetting(() {
                      setState(() {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    SystemChrome.setEnabledSystemUIOverlays([]);
                                  },
                                  child: new AlertDialog(
                                    title: new Text(
                                      "로그아웃",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Noto',
                                      ),
                                    ),
                                    content: Text(
                                      '로그아웃을 하시겠습니까?',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontFamily: 'Noto',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        children: [
                                          FlatButton(
                                            child: Text('예'),
                                            onPressed: () {
                                              setState(() {
                                                VarData().logOut();
                                                SystemChrome
                                                    .setEnabledSystemUIOverlays(
                                                        []);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('아니오'),
                                            onPressed: () {
                                              SystemChrome
                                                  .setEnabledSystemUIOverlays(
                                                      []);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                      });
                    }),

                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '참여한 이벤트\n0',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        VerticalDivider(
                          color: kBodyColor,
                        ),
                        Text(
                          '문의 내역\n0',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 40.0,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Emmaus()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.person_2,
                                    size: 40.0,
                                  ),
                                  Text(
                                    '엠마오',
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "e=프리퀀시",
                                    content: Column(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: kSelectColor,
                                            ),
                                            onPressed: () {
                                              Get.to(Contents());
                                            },
                                            child: Text("2021 하계")),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: kSelectColor,
                                            ),
                                            onPressed: () {
                                              if (VarData().getLogin())
                                                Get.to(Winter());
                                            },
                                            child: Text("2021 동계")),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: kSelectColor,
                                            ),
                                            onPressed: () {
                                              if (VarData().getLogin())
                                                Get.to(SummerFre());
                                            },
                                            child: Text("2022 하계")),
                                      ],
                                    ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.flame,
                                    size: 40.0,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'e-프리퀀시',
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: _launchInstagram,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    LineIcons.instagram,
                                    size: 40.0,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      '인스타그램',
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Game()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.gamecontroller,
                                    size: 40.0,
                                  ),
                                  Text(
                                    '게임',
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: FlatButton(
                            onPressed: _launchHomepage,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.home,
                                  size: 40.0,
                                ),
                                Text(
                                  '홈페이지',
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            ),
                          )),
                          Expanded(
                              child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QtAll()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.checkmark_rectangle,
                                  size: 40.0,
                                ),
                                Text(
                                  '큐티 현황',
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                              child: FlatButton(
                            onPressed: () {
                              TextEditingController controller =
                                  TextEditingController();
                              Get.defaultDialog(
                                title: "문의하기",
                                content: Column(
                                  children: [
                                    Text(
                                      "버그나 수정사항 또는 개선사항을 자유롭게 적어주세요",
                                      style: TextStyle(
                                        fontFamily: "Noto",
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: kBodyColor,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle:
                                                  TextStyle(fontSize: 12),
                                              hintText: "여기에 입력해주세요"),
                                          controller: controller,
                                          maxLines: 8,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                confirm: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kSelectColor,
                                    ),
                                    onPressed: () {
                                      VarData()
                                          .sendQuestion(controller.text)
                                          .then((value) {
                                        if (value == "true") {
                                          Get.back();
                                          Get.snackbar(
                                              "성공", "문의가 성공적으로 전송되었습니다");
                                        }
                                      });
                                    },
                                    child: Text("전송")),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.speaker_3,
                                  size: 40.0,
                                ),
                                Text(
                                  '문의하기',
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            ),
                          )),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: kBodyColor,
                    height: 40.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '그 날에 그들 중 둘이 예루살렘에서 이십오 리 되는\n엠마오라 하는 마을로 가면서\n이 모든 된 일을 서로 이야기하더라\n눅 24:13~14',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Noto',
                            color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchHomepage() async {
    const url = 'https://official-emmaus.com';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  _launchInstagram() async {
    const url = 'https://instagram.com/emmaus_worship?utm_medium=copy_link';
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}

/*GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.person,
                            size: 40.0,
                          ),
                          Text(
                            '개인정보',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.settings,
                            size: 40.0,
                          ),
                          Text(
                            '어플설정',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.gift,
                            size: 40.0,
                          ),
                          Text(
                            '이벤트',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.book,
                            size: 40.0,
                          ),
                          Text(
                            '엠마오 주보',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_text,
                            size: 40.0,
                          ),
                          Text(
                            '1:1문의',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.bag,
                            size: 40.0,
                          ),
                          Text(
                            '엠마오장터',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  )*/
