import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'vardata.dart';
import 'constants.dart';
import 'homebgcolor.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contents extends StatefulWidget {
  @override
  _Contents createState() => _Contents();
}

class _Contents extends State<Contents> {
  final textController = TextEditingController();

  void _checkAnswer(String s) async {
    bool check = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.get("specialDateKey");

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      VarData().check(s).then((value) {
        if (value) {
          Fluttertoast.showToast(
              msg: "정답입니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          SystemChrome.setEnabledSystemUIOverlays([]);
          Navigator.of(context).pop();
          check = true;
        } else {
          print("else");
          Fluttertoast.showToast(
              msg: "오답입니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      }).catchError((onError) {
        print("Error");
      });

      if (check) await prefs.setString('specialDateKey', toDayDate);
    } else {
      Fluttertoast.showToast(
          msg: "오늘의 미션 출석되었습니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  _worshipCheck() async {
    String nowDay = DateFormat('EEEE').format(DateTime.now());
    int nowTime = int.parse(DateFormat('HHmm').format(DateTime.now()));

    bool check = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.get("mDateKey");

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (VarData().isLogin()) {
      if (lastVisitDate != toDayDate) {
        if (nowDay == "Sunday") {
          if (nowTime <= 1600 && nowTime >= 1300) {
            setState(() {
              check = true;
              VarData().setNormal();
              VarData().insertFre();
            });
          }
          if (check) await prefs.setString('mDateKey', toDayDate);
        } else if (nowDay == "Friday") {
          if (nowTime <= 2359 && nowTime >= 2100) {
            setState(() {
              check = true;
              VarData().setNormal();
              VarData().insertFre();
            });
          }
          if (check) await prefs.setString('mDateKey', toDayDate);
        } else {
          Fluttertoast.showToast(
              msg: "예배 출석 시간이 아닙니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "오늘은 이미 출석하셨습니다!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "로그인 후 이용 가능합니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  void _check() {
    if (VarData().isLogin()) {
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
                    "정답",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  content: Container(
                    height: 110,
                    child: Column(
                      children: [
                        Text(
                          '정답은 소문자',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontFamily: 'Noto',
                          ),
                        ),
                        Divider(),
                        TextField(
                            onSubmitted: (String s) {
                              setState(() {
                                _checkAnswer(s);
                                textController.text = "";
                              });
                            },
                            controller: textController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Hint',
                            )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      children: [
                        FlatButton(
                          child: Text('확인'),
                          onPressed: () {
                            setState(() {
                              _checkAnswer(textController.text);
                              textController.text = "";
                            });
                          },
                        ),
                        FlatButton(
                          child: Text('취소'),
                          onPressed: () {
                            textController.text = "";
                            SystemChrome.setEnabledSystemUIOverlays([]);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ));
    } else {
      Fluttertoast.showToast(
          msg: "로그인 후 이용 가능합니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: getColor(),
        padding:
            EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'EMMAUS',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 50.0,
            ),
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 30.0, top: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: _check,
                                child: Text(
                                  "미션 출석",
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Spacer(),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black,
                                        width: 2,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: _worshipCheck,
                                child: Text(
                                  "예배 출석",
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "SHOW\nYOUR WORSHIP!",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 22.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5.0,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              VarData().getData(0),
                              VarData().getData(1),
                              VarData().getData(2),
                              VarData().getData(3),
                              VarData().getData(4),
                              VarData().getData(5),
                              VarData().getData(6),
                              VarData().getData(7),
                              VarData().getData(8),
                            ],
                          ),
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
