import 'dart:convert';

import 'package:emmaus/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

List<String> imgList = [];
List<String> homeList = [];

List<dynamic> _eventFile = [];
List<dynamic> _eventName = [];
List<dynamic> _eventUrl = [];

bool _isLogin = false;
bool _autoLogin = false;

String _id = "";
String _name = "엠마오";
String _cell;
String _team = "엠마오";
String _term = "1";
String _first = "False";
bool _isCheck = false;

List<dynamic> news = [""];
// int newsNum = 0;

String bulletinDate = "";
int bulletinNum = 0;
////////////////////////////////////
int specialNum = 0;
int normalNum = 3;
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

int _dynamicSpecialNum = 0;
int _dynamicNormalNum = 3;
List<Widget> _dynamicIconList = [
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
///////////////////e-frequency

var settings;
var conn;

class VarData {
  int getSpecial(bool isFirst) {
    return isFirst ? specialNum : _dynamicSpecialNum;
  }

  int getNormal(bool isFirst) {
    return isFirst ? normalNum - 3 : _dynamicNormalNum - 3;
  }

  Widget checkESuccess() {
    if (specialNum == 3 && normalNum == 9) {
      return FittedBox(
        fit: BoxFit.fitHeight,
        child: ChooseReward(),
      );
    } else {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                "SHOW\nYOUR WORSHIP!",
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                "6/13 ~ 7/9",
                style: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget checkQt(int progress) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "오늘의 큐티 출석 현황 $progress%",
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  void setNormal(bool isFirst) {
    if (isFirst) {
      if (normalNum < 9) {
        _iconList[normalNum] = kTrueNormal;
        normalNum++;
      }
    } else {
      if (_dynamicNormalNum < 9) {
        _dynamicIconList[_dynamicNormalNum] = kTrueNormal;
        _dynamicNormalNum++;
      }
    }
    Fluttertoast.showToast(
        msg: "예배 출석 완료!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  insertFreReward(String s) async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_frereward_process.php');
    var result = await http.post(url, body: {
      "mb_name": _name,
      "reward": s,
    });
    print(result.body);
  }

  insertFre() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_fre_process.php');
    var result = await http.post(url, body: {
      "mb_id": _id,
      "special": _dynamicSpecialNum.toString(),
      "normal": (_dynamicNormalNum - 3).toString()
    });

    print(result.body);
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
      if (_dynamicSpecialNum < 3) {
        _dynamicIconList[_dynamicSpecialNum] = kTrueSpecial;
        _dynamicSpecialNum++;
      }
      insertFre();
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }

  Widget getData(int i, bool isFirst) {
    return isFirst ? _iconList[i] : _dynamicIconList[i];
  }

  getWinter() async {
    print(_id);
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_winter_fre_init.php');
    var result = await http.post(url, body: {"mb_id": _id});

    print("getQt");
    print(result.body);

    Map<String, dynamic> body = json.decode(result.body);

    _dynamicSpecialNum = int.parse(body['special']);
    _dynamicNormalNum = int.parse(body['normal']) + 3;

    for (int i = 0; i < 3; i++) {
      if (i < _dynamicSpecialNum)
        _dynamicIconList[i] = kTrueSpecial;
      else
        _dynamicIconList[i] = kFalseSpecial;
    }
    for (int i = 3; i < 9; i++) {
      if (i < _dynamicNormalNum)
        _dynamicIconList[i] = kTrueNormal;
      else
        _dynamicIconList[i] = kFalseNormal;
    }
  }

  ////////////////////////////////////e-frequency

  Future<bool> setBible() async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_bible.php');
    var result = await http.post(url, body: {"mb_id": _id});

    if (result.body != "false") {
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>> getBible() async {
    if (DateTime.now().year == 2022) {
      var url = Uri.parse(
          'https://www.official-emmaus.com/g5/bbs/emmaus_bible_init.php');
      var result = await http.post(url, body: {"mb_id": _id});

      print(result.body);
      if (result.body == null) {
        return ["통독", null];
      }
      Map<String, dynamic> body = json.decode(result.body);
      var chapter = body['chapter'];
      var count = body['count'];
      String bible = chapter + count;

      return [bible, body['id']];
    } else {
      return [
        "D${(DateTime.now().difference(DateTime(2022, 01, 01)).inHours / 24).round()}",
        null
      ];
    }
  }

  Future<Map<String, List<dynamic>>> getAllBible() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_bible_all_init.php');
    print(_id);
    var result = await http.post(url, body: {"mb_id": _id});

    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);

    return {
      "date": body['date'],
      "chapter": body['chapter'],
      "count": body['count'],
      "isCheck": body['isCheck']
    };
  }

  Future sendQuestion(String content) async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_question.php');
    var result = await http.post(url, body: {
      "content": content,
    });
    return result.body;
  }

  getEventFile() => _eventFile;
  getEventName() => _eventName;
  getEventUrl() => _eventUrl;

  setCheck() {
    _isCheck = true;
  }

  getCheck() {
    return _isCheck;
  }

  Future<List<dynamic>> getAllQt() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_qt_all_init.php');
    print(_id);
    var result = await http.post(url, body: {"mb_id": _id});

    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    List<dynamic> list = body['date'];

    return list;
  }

  getQt(String mbId) async {
    print(mbId);
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_qt_init.php');
    var result = await http.post(url, body: {"mb_id": mbId});

    print("getQt");
    print(result.body);

    if (result.body != "null") {
      print("check");
      _isCheck = true;
    }
  }

  getId() {
    return _id;
  }

  showBulletin() {
    getBulletin().then((value) {
      String date = bulletinDate;
      int count = bulletinNum;

      for (int i = 0; i < count; i++) {
        String url =
            "https://www.official-emmaus.com/g5/bbs/bulletin/$date" + "_$i.png";

        imgList.add(url);
      }
    });
  }

  getHomeImage() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_news_init.php');
    var result = await http.post(url);
    print("count : ${result.body}");
    Map<String, dynamic> body = json.decode(result.body);

    String name = body['name'];
    int count = int.parse(body['count']);
    for (int i = 0; i < count; i++) {
      String url = "https://www.official-emmaus.com/g5/bbs/news/${name}_$i.png";

      homeList.add(url);
    }
  }

  Future getEvents() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_event_init.php');
    var result = await http.post(url);
    print("event : ${result.body}");
    Map<String, dynamic> body = json.decode(result.body);

    _eventFile = body['file'];
    _eventName = body['name'];
    _eventUrl = body['url'];
    return true;
  }

  // List<dynamic> getNewsContents() {
  //   return news;
  // }

  String getBulletinDate() {
    return bulletinDate;
  }

  int getBulletinNum() {
    return bulletinNum;
  }

  Future getBulletin() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_bulletin_json.php');
    var result = await http.post(url);

    Map<String, dynamic> body = json.decode(result.body);

    bulletinDate = body['date'];
    bulletinNum = int.parse(body['count']);

    //print(bulletinDate);
    //print(bulletinNum);
  }

  Future<String> compVersion() async {
    String res;
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_version_android_json.php');
    var result = await http.post(url);

    Map<String, dynamic> body = json.decode(result.body);

    res = body['android'];

    return res;
  }

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

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("autologin", false);
    _isLogin = false;
  }

  String getName() {
    if (!_isLogin) {
      _name = "엠마오";
    }
    return _name;
  }

  // Widget getContent() {
  //   if (_isLogin) {
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               IconButton(
  //                 icon: Icon(FontAwesomeIcons.angleDoubleLeft),
  //                 onPressed: () {
  //                   if (newsNum > 0) {
  //                     newsNum--;
  //                   }
  //                 },
  //               ),
  //               FittedBox(
  //                 fit: BoxFit.fitHeight,
  //                 child: Text(
  //                   news[newsNum],
  //                   style: TextStyle(
  //                     fontFamily: 'Noto',
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: Icon(FontAwesomeIcons.angleDoubleRight),
  //                 onPressed: () {
  //                   if (newsNum < news.length - 1) {
  //                     newsNum++;
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return LoginWidget();
  //   }
  // }

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
    _isCheck = false;
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
    if (_cell != null) {
      _isLogin = true;
      _id = id;
      print("_id : $_id");
      getQt(_id);
    }

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

class ChooseReward extends StatelessWidget {
  const ChooseReward({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10)),
      onPressed: null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              CupertinoIcons.gift_fill,
              color: Colors.green[700],
            ),
            Text(
              "경품선택",
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
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
