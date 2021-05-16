import 'dart:convert';

import 'package:emmaus/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';

bool _isLogin = false;

String _name = "엠마오";
String _cell = "엠마오";
String _team = "엠마오";
String _term = "1";

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

List<String> _answerSpecialList = ["special1", "special2", "special3"];

List<String> _answerNormalList = [
  "normal1",
  "normal2",
  "normal3",
  "normal4",
  "normal5",
  "normal6"
];

class VarData {
  bool setIcon(String s) {
    if (s == _answerNormalList[normalNum - 3]) {
      _iconList[normalNum] = kTrueNormal;
      if (normalNum < 8) normalNum++;
      return true;
    } else {
      if (s == _answerSpecialList[specialNum]) {
        _iconList[specialNum] = kTrueSpecial;
        if (specialNum < 2) specialNum++;
        return true;
      } else {
        return false;
      }
    }
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
      return Text(
        "오늘은 " +
            DateFormat("yyyy년MM월dd일").format(DateTime.now()).toString() +
            "입니다!",
        style: TextStyle(
          fontFamily: 'Noto',
          fontWeight: FontWeight.w900,
          fontSize: 20.0,
        ),
      );
    } else {
      return LoginWidget();
    }
  }

  Widget getSetting() {
    if (_isLogin) {
      return Text(
        '$_cell셀\n$_team팀\n$_term기',
        style: TextStyle(
          fontFamily: 'Noto',
          fontSize: 15.0,
          fontWeight: FontWeight.w700,
        ),
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

  void post(String id, String password) async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/app_login_check.php');
    var result =
        await http.post(url, body: {"mb_id": id, "mb_password": password});
    print(result.body);
    //0 : name / 1 : isFirst / 2 : cell / 3 : team / 4 : term / 5 : special / 6 : normal
    _name = result.body[0];
    _cell = result.body[2];
    _team = result.body[3];
    _term = result.body[4];
    _isLogin = true;
  }

/*
  void connectSQL() async {
    settings = new ConnectionSettings(
        host: 'box5380.bluehost.com',
        user: 'offickt2_app',
        port: 3306,
        password: 'Cjswosla!2',
        db: 'offickt2_emmaus');
    print("settings : ");
    print(settings);
    conn = await MySqlConnection.connect(settings);
    print("conn : ");
    print(conn);
  }

  Future<bool> loginCheck(String id, String pass) async {
    connectSQL();
    var results = await conn.query(
        "SELECT mb_name FROM em_member WHERE mb_id = ? and mb_password = PASSWORD('?')",
        [id, pass]);
    print(results);
  }*/
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
