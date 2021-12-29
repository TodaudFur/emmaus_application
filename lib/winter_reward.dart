import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';
import 'homebgcolor.dart';

class WinterReward extends StatefulWidget {
  @override
  _WinterRewardState createState() => _WinterRewardState();
}

class _WinterRewardState extends State<WinterReward> {
  String reward;
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
                                    'E-프리퀀시 경품 선택',
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
                                value: "머그컵",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value;
                                  });
                                },
                              ),
                              Text(
                                '머그컵',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "텀블러",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value;
                                  });
                                },
                              ),
                              Text(
                                '텀블러',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "맨투맨",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value;
                                  });
                                },
                              ),
                              Text(
                                '맨투맨',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Noto',
                                ),
                              ),
                              Radio(
                                value: "머플러",
                                groupValue: reward,
                                onChanged: (value) {
                                  setState(() {
                                    reward = value;
                                  });
                                },
                              ),
                              Text(
                                '머플러',
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
      case "머그컵":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Text(
                  '머그컵은 블랙+화이트 총 2개가 제공됩니다.',
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
                    VarData().insertFreReward("머그컵");

                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "선택하기",
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
      case "텀블러":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '텀블러는 1개가 제공됩니다.',
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
                    VarData().insertFreReward("텀블러");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "선택하기",
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
      case "맨투맨":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Column(
            children: [
              Text(
                '맨투맨 $size사이즈로 제공됩니다.',
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
                        size = value;
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
                        size = value;
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
                        size = value;
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
                        size = value;
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
                        size = value;
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
                  VarData().insertFreReward("맨투맨 : $size");
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "경품이 선택되었습니다!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                },
                child: Text(
                  "선택하기",
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
      case "머플러":
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '머플러는 1개가 제공됩니다',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Text(
                    '*색상은 개별문의바랍니다',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto',
                        fontSize: 10),
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
                    VarData().insertFreReward("머플러");
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "경품이 선택되었습니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  },
                  child: Text(
                    "선택하기",
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
