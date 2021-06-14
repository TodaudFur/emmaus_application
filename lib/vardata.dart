import 'dart:convert';

import 'package:emmaus/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

bool _isLogin = false;
bool _autoLogin = false;

String _name = "엠마오";
String _cell;
String _team = "엠마오";
String _term = "1";
String _first = "False";

int specialNum = 0;
int normalNum = 3;

var settings;
var conn;

List<Widget> _iconList = [
  kFalseSpecial,
  kFalseSpecial,
  kFalseSpecial,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
];

class VarData {
  bool getLogin() {
    return _isLogin;
  }

  void trueAutoLogin(String id, String pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("autologin", true);
    await prefs.setString("autoid", id);
    await prefs.setString("autopwd", pwd);
    _autoLogin = true;
  }

  void reLogin() {
    _first = "True";
  }

  int getSpecial() {
    return specialNum;
  }

  int getNormal() {
    return normalNum - 3;
  }

  bool getFirst() {
    if (_first == "False")
      return true;
    else
      return false;
  }

  firstChange(String password, String email) async {
    print(_name);
    print(password);
    print(email);
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_password_process.php');
    var result = await http.post(url,
        body: {"mb_name": _name, "password": password, "email": email});

    print(result.body);
  }

  bool isLogin() {
    if (_isLogin)
      return true;
    else
      return false;
  }

  void setNormal() {
    if (normalNum < 9) {
      _iconList[normalNum] = kTrueNormal;
      normalNum++;

      Fluttertoast.showToast(
          msg: "예배 출석 완료!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  insertFre() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_fre_process.php');
    var result = await http.post(url, body: {
      "mb_name": _name,
      "special": specialNum.toString(),
      "normal": (normalNum - 3).toString()
    });

    Map<String, dynamic> body = json.decode(result.body);
  }

  Future<List<String>> pullBulletin() async {
    List<String> res;
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_bulletin_json.php');
    var result = await http.post(url);

    Map<String, dynamic> body = json.decode(result.body);

    res.add(body['date']);
    res.add(body['count']);

    return res;
  }

  Future<bool> check(String answer) async {
    String date = DateFormat("MMdd").format(DateTime.now()).toString();
    print("result");
    print(answer);
    print(date);
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_answer_json.php');
    var result = await http.post(url, body: {"answer": answer, "date": date});

    print(result.body);

    Map<String, dynamic> body = json.decode(result.body);

    print(body);

    print(body["result"]);
    if (body["result"] == "true") {
      if (specialNum < 3) {
        _iconList[specialNum] = kTrueSpecial;
        specialNum++;
      }
      insertFre();
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("autologin", false);
    _isLogin = false;
  }

  Widget getData(int i) {
    return _iconList[i];
  }

  String getName() {
    if (!_isLogin) {
      _name = "엠마오";
    }
    return _name;
  }

  Widget getContent() {
    if (_isLogin) {
      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "e-프리퀀시",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(flex: 4, child: Container()),
                          Expanded(
                            flex: 4,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Icon(
                                CupertinoIcons.flame_fill,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                specialNum.toString(),
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Expanded(flex: 3, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "+",
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                            flex: 4,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Icon(
                                CupertinoIcons.book_fill,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                (normalNum - 3).toString(),
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          Expanded(flex: 3, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "=",
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Container()),
                          Expanded(
                            flex: 4,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Icon(
                                CupertinoIcons.gift,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Expanded(
                            flex: 2,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                (specialNum + (normalNum - 3)).toString(),
                                style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w900,
                                ),
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
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      );
    } else {
      return LoginWidget();
    }
  }

  Widget getSetting(Function onpress) {
    if (_isLogin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_cell셀 / $_team팀 / $_term기',
            style: TextStyle(
              fontFamily: 'Noto',
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: kBodyColor,
              onPressed: onpress,
              child: Text(
                "로그아웃",
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: LoginWidget(),
        ),
      );
    }
  }

  Future<bool> post(String id, String password) async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/app_login_check.php');
    var result =
        await http.post(url, body: {"mb_id": id, "mb_password": password});
    //print(result.body);
    //0 : name / 1 : isFirst / 2 : cell / 3 : team / 4 : term / 5 : special / 6 : normal

    Map<String, dynamic> body = json.decode(result.body);
    _name = body["name"];
    _cell = body["cell"];
    _team = body["team"];
    _term = body["term"];
    _first = body["isFirst"];
    specialNum = int.parse(body["special"]);
    normalNum = (int.parse(body["normal"]) + 3);
    if (_cell != null) _isLogin = true;

    for (int i = 0; i < 3; i++) {
      if (i < specialNum)
        _iconList[i] = kTrueSpecial;
      else
        _iconList[i] = kFalseSpecial;
    }
    for (int i = 3; i < 9; i++) {
      if (i < normalNum)
        _iconList[i] = kTrueNormal;
      else
        _iconList[i] = kFalseNormal;
    }

    //print(result.isRedirect);

    if (_isLogin)
      return true;
    else
      return false;
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: kBodyColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Text(
        "로그인",
        style: TextStyle(
          fontFamily: 'Noto',
          fontWeight: FontWeight.w900,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
