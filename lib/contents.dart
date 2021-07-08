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
  int tryTime = 2;

  _getTryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDayDate = DateFormat('MMdd').format(DateTime.now());
    String lastVisitDate = prefs.get("tryTimeDate");

    if (toDayDate != lastVisitDate) {
      await prefs.setString('tryTimeDate', toDayDate);
      tryTime = 2;
    } else {
      if (tryTime != prefs.getInt("tryTime")) {
        setState(() {
          tryTime = prefs.getInt("tryTime");
          if (tryTime == null) tryTime = 2;
        });
      }
    }
  }

  void _checkAnswer(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.get("specialDateKey");

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      VarData().check(s).then((value) async {
        if (value) {
          await prefs.setString('specialDateKey', toDayDate);
          Fluttertoast.showToast(
              msg: "정답입니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          SystemChrome.setEnabledSystemUIOverlays([]);
          setState(() {
            Navigator.of(context).pop();
          });
        } else {
          if (tryTime == 0) {
            Fluttertoast.showToast(
                msg: "정답 입력 기회를 다 사용했습니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          } else {
            setState(() {
              tryTime--;
            });
            await prefs.setInt('tryTime', tryTime);
            Fluttertoast.showToast(
                msg: "오답입니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        }
      }).catchError((onError) {
        print("Error");
      });
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

    int endDate = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    print(endDate);

    if (endDate > 20210709) {
      Fluttertoast.showToast(
          msg: "21 서머 e-프리퀀시 기간이 끝났습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (VarData().isLogin()) {
        if (VarData().getNormal() == 6) {
          Fluttertoast.showToast(
              msg: "예배 출석을 모두 성공하셨습니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          if (lastVisitDate != toDayDate) {
            if (nowDay == "Sunday") {
              if (nowTime <= 1700 && nowTime >= 1400) {
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
  }

  void _check() {
    int endDate = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    print(endDate);

    if (endDate > 20210709) {
      Fluttertoast.showToast(
          msg: "21 서머 e-프리퀀시 기간이 끝났습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (VarData().isLogin()) {
        if (VarData().getSpecial() == 3) {
          Fluttertoast.showToast(
              msg: "미션을 모두 성공하셨습니다!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
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
                          height: 130,
                          child: Column(
                            children: [
                              Text(
                                '아래에 정답을 입력해주세요.\n(입력 기회 : $tryTime/2)',
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
                                    labelText: '정답',
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
                    );
                  }));
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
  }

  @override
  Widget build(BuildContext context) {
    _getTryTime();
    return SafeArea(
      child: Container(
        color: getColor(),
        padding:
            EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 7.0, bottom: 12.0, left: 9.0, right: 9.0),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Image.asset("images/logo_ema.png"),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: _check,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      "스페셜미션",
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: _worshipCheck,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      "예배 출석",
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
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
                      child: VarData().checkESuccess(),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: VarData().getData(0),
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: VarData().getData(1),
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: VarData().getData(2),
                                        ))),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: VarData().getData(3),
                                      )),
                                ),
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: VarData().getData(4),
                                        ))),
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: VarData().getData(5),
                                        ))),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: VarData().getData(6),
                                        ))),
                                Expanded(
                                    child: FittedBox(
                                        fit: BoxFit.fitHeight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: VarData().getData(7),
                                        ))),
                                Expanded(
                                    child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: VarData().getData(8),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
