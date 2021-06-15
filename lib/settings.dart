import 'package:emmaus/constants.dart';
import 'package:emmaus/game.dart';
import 'package:emmaus/vardata.dart';
import 'package:emmaus/versedata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
              flex: 6,
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
                    flex: 4,
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
                              onPressed: () {
                                String toDayDate =
                                    DateFormat('dd').format(DateTime.now());
                                int num = int.parse(toDayDate);
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            SystemChrome
                                                .setEnabledSystemUIOverlays([]);
                                          },
                                          child: new AlertDialog(
                                            title: new Text(
                                              "오늘의 큐티",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      VerseData()
                                                          .getQt(num - 15),
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Noto',
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(),
                                                  Expanded(
                                                    flex: 9,
                                                    child: Container(
                                                      child: TextField(
                                                          maxLines: null,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          controller:
                                                              textController,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText: '큐티',
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                children: [
                                                  FlatButton(
                                                    child: Text('확인'),
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text:
                                                                  textController
                                                                      .text));
                                                      textController.text = "";
                                                      Navigator.of(context)
                                                          .pop();
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "큐티가 클립보드에 복사되었습니다.",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          fontSize: 16.0);
                                                    },
                                                  ),
                                                  FlatButton(
                                                    child: Text('취소'),
                                                    onPressed: () {
                                                      textController.text = "";
                                                      SystemChrome
                                                          .setEnabledSystemUIOverlays(
                                                              []);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.doc_text,
                                    size: 40.0,
                                  ),
                                  Text(
                                    '오늘의 큐티',
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
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
                                    FontAwesomeIcons.instagram,
                                    size: 40.0,
                                  ),
                                  Text(
                                    '인스타그램',
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
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: kBodyColor,
                    height: 40.0,
                  ),
                  Expanded(
                    flex: 3,
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
                  Expanded(flex: 4, child: Container()),
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

  _showBulletin() {
    VarData().pullBulletin().then((value) {
      String date = value[0];
      String count = value[1];
      List<Widget> image;

      for (int i = 0; i < int.parse(count); i++) {
        image.add(Image.network(
            "https://www.official-emmaus.com/g5/bbs/bulletin/$date" +
                "_$i.png"));
      }

      showDialog(
          context: context,
          builder: (context) => Scaffold(
                body: Center(
                  child: Row(
                    children: image,
                  ),
                ),
              ));
    }).catchError((onError) {});
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
