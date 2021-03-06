import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';
import 'homebgcolor.dart';

class EReward extends StatefulWidget {
  @override
  _ERewardState createState() => _ERewardState();
}

class _ERewardState extends State<EReward> {
  late String reward;
  String size = "";
  final wirelessController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.arrow_left),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: getColor(),
                padding: EdgeInsets.only(
                    top: 70.0, left: 30.0, right: 30.0, bottom: 100.0),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0, right: 20.0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(flex: 3, child: Container()),
                              Expanded(
                                flex: 6,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'E-???????????? ?????? ??????',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Noto',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(flex: 3, child: Container()),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: "?????????",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              Text(
                                '?????????',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "?????????",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              Text(
                                '?????????',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "?????????",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              Text(
                                '?????????',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "????????????",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value.toString();
                                  });
                                },
                              ),
                              Text(
                                '????????????',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: detail(),
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

  Widget detail() {
    switch (reward) {
      case "?????????":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Text(
                  '???????????? ??????+????????? ??? 2?????? ???????????????.',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Noto',
                  ),
                ),
                Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    VarData().insertFreReward("?????????");

                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "????????? ?????????????????????!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "????????????",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case "?????????":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '???????????? 1?????? ???????????????.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ),
                Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    VarData().insertFreReward("?????????");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "????????? ?????????????????????!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "????????????",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case "?????????":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Column(
            children: [
              Text(
                '???????????? $size??? ??????+????????? 2?????? ???????????????.',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Noto',
                ),
              ),
              Row(
                children: [
                  Radio(
                    value: "S",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  Text(
                    'S',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "M",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  Text(
                    'M',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "L",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  Text(
                    'L',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "XL",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  Text(
                    'XL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Radio(
                    value: "XXL",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() {
                        size = value.toString();
                      });
                    },
                  ),
                  Text(
                    'XXL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 30.0,
                color: Colors.white,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  VarData().insertFreReward("????????? : $size");
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "????????? ?????????????????????!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                },
                child: Text(
                  "????????????",
                  style: TextStyle(
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case "????????????":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Text(
                  '???????????? ??????\n?????????+?????? ????????? ?????????+????????? ?????????',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Noto',
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "?????? ????????? ????????? : ",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Noto',
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 130,
                      child: TextField(
                          controller: wirelessController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 45.0,
                    ),
                    Text(
                      "????????? ?????? : ",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Noto',
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 130,
                      child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                    ),
                  ],
                ),
                Divider(
                  height: 30.0,
                  color: Colors.white,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    String ws = wirelessController.text;
                    String ps = phoneController.text;
                    VarData().insertFreReward("???????????? : ???????????????=$ws, ?????????=$ps");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "????????? ?????????????????????!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "????????????",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }
}
