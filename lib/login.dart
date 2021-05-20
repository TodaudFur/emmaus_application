import 'package:emmaus/constants.dart';
import 'package:emmaus/firstlogin.dart';
import 'package:emmaus/home.dart';
import 'package:emmaus/myhomepage.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final psController = TextEditingController();

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
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.only(left: 15.0, top: 10.0),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(CupertinoIcons.arrow_left),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )),
                Expanded(
                  flex: 95,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      alignment: Alignment.topCenter,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/emmaus_logo.png",
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
                            height: 40.0,
                          ),
                          RaisedButton(
                            color: kSelectColor,
                            padding: EdgeInsets.only(left: 40.0, right: 40.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {
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
