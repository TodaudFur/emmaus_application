import 'package:emmaus/constants.dart';
import 'package:emmaus/firstlogin.dart';
import 'package:emmaus/myhomepage.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'find.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final psController = TextEditingController();
  bool autoLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            SystemChrome.setEnabledSystemUIOverlays([]);
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(CupertinoIcons.arrow_left),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/logo_em_3.png",
                            height: 70.0,
                            color: kSelectColor,
                          ),
                          Divider(
                            color: Colors.white,
                            height: 40.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                onSubmitted: (String s) {},
                                controller: idController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ID',
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {},
                                controller: psController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Switch(
                                      value: autoLogin,
                                      onChanged: (value) {
                                        setState(() {
                                          autoLogin = value;
                                        });
                                      }),
                                  Text(
                                    "자동로그인",
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return Find("id");
                                      }));
                                    },
                                    child: Text("아이디 찾기"),
                                    style: TextButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return Find("pwd");
                                      }));
                                    },
                                    child: Text("비밀번호 초기화"),
                                    style: TextButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          RaisedButton(
                            color: kSelectColor,
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {
                              Get.dialog(const Center(
                                child: CircularProgressIndicator(),
                              ));
                              setState(() {
                                VarData()
                                    .post(idController.text, psController.text)
                                    .then((value) {
                                  if (VarData().getFirst()) {
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FirstLogin()),
                                            (route) => false)
                                        .then((value) => setState(() {}));
                                  } else {
                                    Get.back();
                                    if (autoLogin)
                                      VarData().trueAutoLogin(
                                          idController.text, psController.text);
                                    Fluttertoast.showToast(
                                        msg: "로그인 성공!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()),
                                            (route) => false)
                                        .then((value) => setState(() {}));
                                  }
                                }).catchError((onError) {
                                  Fluttertoast.showToast(
                                      msg: "로그인 실패! : 아이디 또는 비밀번호를 확인해주세요.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                });
                                SystemChrome.setEnabledSystemUIOverlays([]);
                              });
                            },
                            child: Text(
                              "로그인",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
