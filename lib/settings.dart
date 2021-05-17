import 'package:emmaus/constants.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 50.0, left: 40.0, right: 40.0),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '안녕하세요 엠마오님',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    VarData().getSetting(() {
                      setState(() {
                        VarData().logOut();
                      });
                    }),
                    Divider(
                      color: kBodyColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: Image.asset(
                          "images/blue_emmaus_logo.jpg",
                          height: 70.0,
                        ),
                      ),
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '참여한 이벤트\n0',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        VerticalDivider(
                          color: kBodyColor,
                        ),
                        Text(
                          '문의 내역\n0',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 80.0,
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Container(
                  height: 200.0,
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      '그 날에 그들 중 둘이 예루살렘에서 이십오 리 되는\n엠마오라 하는 마을로 가면서\n이 모든 된 일을 서로 이야기하더라\n눅 24:13~14',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.person,
                            size: 40.0,
                          ),
                          Text(
                            '개인정보',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.settings,
                            size: 40.0,
                          ),
                          Text(
                            '어플설정',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.gift,
                            size: 40.0,
                          ),
                          Text(
                            '이벤트',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.book,
                            size: 40.0,
                          ),
                          Text(
                            '엠마오 주보',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble_text,
                            size: 40.0,
                          ),
                          Text(
                            '1:1문의',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.bag,
                            size: 40.0,
                          ),
                          Text(
                            '엠마오장터',
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                            ),
                          )
                        ],
                      ),
                    ],
                  )*/
