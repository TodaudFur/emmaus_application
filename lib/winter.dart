import 'dart:convert';

import 'package:emmaus/constants.dart';
import 'package:emmaus/winter_reward.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homebgcolor.dart';
import 'vardata.dart';

class Winter extends StatefulWidget {
  @override
  _Winter createState() => _Winter();
}

class _Winter extends State<Winter> with TickerProviderStateMixin {
  final textController = TextEditingController();
  int tryTime = 2;
  double progressValue = 0;
  Color? progressColor = Colors.red[300];
  late AnimationController controller;
  String question = "";
  bool isReward = false;
  //int special = 0;
  //int normal = 0;

  @override
  void initState() {
    getQuestion();
    getQTCount();
    VarData().getWinter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getTryTime();
    return Scaffold(
      body: SafeArea(
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
                          child: isReward
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kSelectColor),
                                  onPressed: () {
                                    Get.to(WinterReward());
                                  },
                                  child: Text("????????????"))
                              : Row(
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
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: _check,
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              "???????????????",
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
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          onPressed: _worshipCheck,
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Text(
                                              "?????? ??????",
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: 300,
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: controller == null ? 0 : controller.value,
                            color: progressColor,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: VarData().checkQt((progressValue * 100).toInt()),
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
                                            child: VarData().getData(0, false),
                                          ))),
                                  Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: VarData().getData(1, false),
                                          ))),
                                  Expanded(
                                      flex: 2,
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: VarData().getData(2, false),
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
                                          child: VarData().getData(3, false),
                                        )),
                                  ),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: VarData().getData(4, false),
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: VarData().getData(5, false),
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
                                            child: VarData().getData(6, false),
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: VarData().getData(7, false),
                                          ))),
                                  Expanded(
                                      child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: VarData().getData(8, false),
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
      ),
    );
  }

  _getTryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDayDate = DateFormat('MMdd').format(DateTime.now());
    String lastVisitDate = prefs.getString("tryTimeDateWinter")!;

    if (toDayDate != lastVisitDate) {
      await prefs.setString('tryTimeDateWinter', toDayDate);
      tryTime = 2;
    } else {
      if (tryTime != prefs.getInt("tryTimeWinter")) {
        setState(() {
          tryTime = prefs.getInt("tryTimeWinter")!;
          if (tryTime == null) tryTime = 2;
        });
      }
    }
  }

  void _checkAnswer(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.getString("specialDateKeyWinter")!;

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      VarData().check(s).then((value) async {
        Navigator.pop(context);
        if (value) {
          await prefs.setString('specialDateKeyWinter', toDayDate);
          Fluttertoast.showToast(
              msg: "???????????????.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else {
          if (tryTime == 0) {
            Fluttertoast.showToast(
                msg: "?????? ?????? ????????? ??? ??????????????????!",
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
                msg: "???????????????!",
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
          msg: "????????? ????????? ?????? ?????????????????????!",
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
    String lastVisitDate = prefs.getString("mDateKeyWinter")!;

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    int endDate = int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    print(endDate);

    if (endDate > 20211225) {
      Fluttertoast.showToast(
          msg: "21 ?????? e-???????????? ????????? ???????????????.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (VarData().isLogin()) {
        if (VarData().getNormal(false) == 6) {
          Fluttertoast.showToast(
              msg: "?????? ????????? ?????? ?????????????????????!",
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
                  VarData().setNormal(false);
                  VarData().insertFre();
                });
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else if (nowDay == "Friday" && toDayDate != "1224") {
              if (nowTime <= 2359 && nowTime >= 2100) {
                setState(() {
                  check = true;
                  VarData().setNormal(false);
                  VarData().insertFre();
                });
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else if (nowDay == "Saturday" && toDayDate == "1225") {
              if (nowTime <= 1300 && nowTime >= 0700) {
                setState(() {
                  check = true;
                  VarData().setNormal(false);
                  VarData().insertFre();
                });
              }
              if (check) await prefs.setString('mDateKeyWinter', toDayDate);
            } else {
              Fluttertoast.showToast(
                  msg: "?????? ?????? ????????? ????????????!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  fontSize: 16.0);
            }
          } else {
            Fluttertoast.showToast(
                msg: "????????? ?????? ?????????????????????!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        }
      } else {
        Fluttertoast.showToast(
            msg: "????????? ??? ?????? ???????????????!",
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

    if (endDate > 20211225) {
      Fluttertoast.showToast(
          msg: "22 ?????? e-???????????? ????????? ???????????????.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (VarData().isLogin()) {
        if (VarData().getSpecial(false) == 3) {
          Fluttertoast.showToast(
              msg: "????????? ?????? ?????????????????????!",
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
                          "???????????????",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Noto',
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                '?????? : $question',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Text(
                                '(?????? ?????? : $tryTime/2)',
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
                                    labelText: '??????',
                                  )),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              FlatButton(
                                child: Text('??????'),
                                onPressed: () {
                                  setState(() {
                                    _checkAnswer(textController.text);
                                    textController.text = "";
                                  });
                                },
                              ),
                              FlatButton(
                                child: Text('??????'),
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
            msg: "????????? ??? ?????? ???????????????!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }

  getQTCount() async {
    print(VarData().getId());
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_winter_qt.php');
    var result = await http.post(url, body: {
      "mb_id": VarData().getId(),
    });
    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    setState(() {
      int count = int.parse(body['count'].toString());
      progressValue = (count / 24);
      print("count : $count / progressValue : $progressValue");
      if (progressValue < 0.4) {
        progressColor = Colors.red[300];
      } else if (progressValue < 0.7) {
        progressColor = Colors.orange[300];
      } else {
        progressColor = Colors.green[300];
      }
      if (VarData().getSpecial(false) == 3 &&
          VarData().getNormal(false) == 6 &&
          (progressValue * 100) >= 70) {
        isReward = true;
      }
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: progressValue,
    )..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  getQuestion() async {
    String date = DateFormat("MMdd").format(DateTime.now()).toString();
    print(date);
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_fre_question.php');
    var result = await http.post(url, body: {
      "date": date,
    });
    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    question = body['question'];
  }
}
