import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus/ereward.dart';
import 'package:emmaus/home.dart';
import 'package:emmaus/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

List<String> imgList = [];
List<String> homeList = [];

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
int newsNum = 0;

String bulletinDate = "";
int bulletinNum = 0;

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
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_qt_init.php');
    var result = await http.post(url, body: {"mb_id": mbId});

    print(result.body);

    if (result.body != null) {
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

  getHomeImage() {
    for (int i = 1; i < 7; i++) {
      String url = "https://www.official-emmaus.com/news/00$i.png";

      homeList.add(url);
    }
  }

  List<dynamic> getNewsContents() {
    return news;
  }

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

  insertFreReward(String s) async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_frereward_process.php');
    var result = await http.post(url, body: {
      "mb_name": _name,
      "reward": s,
    });

    Map<String, dynamic> body = json.decode(result.body);
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

  getNews() async {
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_news_json.php');
    var result = await http.post(url, body: {});

    print(result.body);

    Map<String, dynamic> body = json.decode(result.body);

    news = body['contents'];
  }

  Widget getContent() {
    if (_isLogin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.angleDoubleLeft),
                  onPressed: () {
                    if (newsNum > 0) {
                      newsNum--;
                    }
                  },
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    news[newsNum],
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.angleDoubleRight),
                  onPressed: () {
                    if (newsNum < news.length - 1) {
                      newsNum++;
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EReward()),
        );
      },
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
