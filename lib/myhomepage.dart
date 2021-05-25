import 'package:emmaus/contents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alarm.dart';
import 'constants.dart';
import 'home.dart';
import 'settings.dart';
import 'todayverse.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Contents(),
    Text(
      '',
    ),
    TodayVerse(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kBodyColor),
    );
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIOverlays([]);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBodyColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: _launchURL,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 0.0,
                    ),
                    shape: BoxShape.circle,
                    color: kSelectColor),
                child: Center(
                  child: new Tab(
                      icon: new Image.asset(
                    "images/logo_em_3.png",
                    scale: 4.0,
                  )),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              iconSize: MediaQuery.of(context).size.height / 30,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.flame_fill),
                  label: 'e-프리퀀시',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      null,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book_fill),
                  label: '오늘의 말씀',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '설정',
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0),
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Noto',
                  fontWeight: FontWeight.w700,
                  fontSize: 10.0),
              selectedItemColor: kSelectColor,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://youtube.com/channel/UChKWnwNuFsgzZ1pIwVnPCvA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
