import 'package:emmaus/login.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';
import 'myhomepage.dart';

class FirstLogin extends StatefulWidget {
  @override
  _FirstLoginState createState() => _FirstLoginState();
}

class _FirstLoginState extends State<FirstLogin> {
  final emController = TextEditingController();
  final psController = TextEditingController();
  final cpsController = TextEditingController();

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
                          Navigator.of(context)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                  (route) => false)
                              .then((value) => setState(() {}));
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
                            "images/logo_em_3.png",
                            height: 70.0,
                            color: kSelectColor,
                          ),
                          Divider(
                            color: Colors.white,
                            height: 40.0,
                          ),
                          Text(
                            "?????? ???????????? ??????",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 18.0,
                                color: Colors.black),
                          ),
                          Text(
                            "????????? ????????? ?????????, ??????????????? ???????????? ????????? ????????????!\n" +
                                "????????? ??????????????? ???????????? ?????????????????? ????????????.\n",
                            style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                                fontSize: 10.0,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                onSubmitted: (String s) {},
                                controller: psController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '??? ????????????',
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {},
                                controller: cpsController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '???????????? ??????',
                                ),
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              TextField(
                                onSubmitted: (String s) {},
                                controller: emController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'E-Mail',
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
                                if (psController.text == cpsController.text) {
                                  VarData()
                                      .firstChange(
                                          psController.text, emController.text)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: "??????????????? ?????????????????????. ?????? ?????????????????????!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                    VarData().reLogin();
                                    Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()),
                                            (route) => false)
                                        .then((value) => setState(() {}));
                                  }).catchError((onError) {
                                    print(onError);
                                    Fluttertoast.showToast(
                                        msg: "??????????????? ????????? ?????????????????????! ?????? ??????????????????!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0);
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "??????????????? ?????? ????????????.\n?????? ??????????????????",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16.0);
                                }
                                SystemChrome.setEnabledSystemUIOverlays([]);
                              });
                            },
                            child: Text(
                              "??????",
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
