import 'package:emmaus/escape_room_end.dart';
import 'package:emmaus/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class EscapeRoomSasun extends StatefulWidget {
  @override
  _EscapeRoomSasunState createState() => _EscapeRoomSasunState();
}

class _EscapeRoomSasunState extends State<EscapeRoomSasun> {
  int roomNum = 1;
  final textController = TextEditingController();

  List<String> hint = [
    "#영어소문자 #다섯글자 #마4:1~11 #예수님 #마귀",
    "#영어소문자 #다섯글자 #마4:17 #예수님 #공생애",
    "#영어소문자 #네글자 #마8:1~17 #예수님 #사역",
    "#영어소문자 #네글자 #마13:1~9 #예수님 #이야기",
    "#영어소문자 #네글자 #마16:16 #예수님 #최고",
    "#숫자 #네자리 #마18:1~4 #예수님 #천국",
    "#숫자 #네자리 #마21:1~11 #예수님 #입장",
    "#영어소문자 #여덟글자 #마22:34~40 #예수님 #제자들",
    "#영어소문자 #다섯글자 #마24:1~24 #예수님 #행동",
    "#영어소문자 #다섯글자 #마26:17~35 #예수님 #음식",
    "#영어소문자 #네글자 #마27:27~56 #예수님 #선물",
    "#영어소문자 #네글자 #마28:1~20 #예수님 #우리",
  ];
  List<String> answer = [
    "tempt",
    "begin",
    "heal",
    "hear",
    "king",
    "5000",
    "1101",
    "neighbor",
    "stand",
    "bread",
    "save",
    "free",
  ];

  @override
  Widget build(BuildContext context) {
    _getNum();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.arrow_left),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.home),
                          onPressed: () {
                            Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Game()),
                                    (route) => false)
                                .then((value) => setState(() {}));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Image.asset(
                                    'images/escape_room_$roomNum.png'),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        hint[roomNum - 1],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                          fontFamily: 'Noto',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '아래에 정답을 입력해주세요.',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontFamily: 'Noto',
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    ),
                                    TextField(
                                        onSubmitted: (String s) {
                                          setState(() {
                                            textController.text = "";
                                          });
                                        },
                                        controller: textController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '정답',
                                        )),
                                    RaisedButton(
                                      color: kSelectColor,
                                      padding: EdgeInsets.only(
                                          left: 40.0, right: 40.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      onPressed: () {
                                        if (textController.text ==
                                            answer[roomNum - 1]) {
                                          Fluttertoast.showToast(
                                              msg: "정답입니다.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              fontSize: 16.0);
                                          setState(() {
                                            if (roomNum == 12) {
                                              Fluttertoast.showToast(
                                                  msg: "방탈출 성공!",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  fontSize: 16.0);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EscapeRoomEnd()),
                                              );
                                            } else {
                                              textController.text = "";
                                              roomNum++;
                                              _saveState();
                                            }
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "틀렸습니다.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Text(
                                        "확인",
                                        style: TextStyle(
                                            fontFamily: 'Noto',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 40.0,
                color: kBodyColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  _saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('roomNum', roomNum);
  }

  _getNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (roomNum != prefs.getInt("roomNum")) {
      setState(() {
        roomNum = prefs.getInt("roomNum");
        if (roomNum == null) roomNum = 1;
      });
    }
    print(roomNum);
  }
}
