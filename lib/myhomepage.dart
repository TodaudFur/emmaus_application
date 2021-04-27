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
    TodayVerse(),
    Text(
      '',
    ),
    Alarm(),
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
    return Scaffold(
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
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.0,
                  ),
                  shape: BoxShape.circle,
                  color: kSelectColor),
              child: Icon(CupertinoIcons.arrowtriangle_right_fill, size: 30),
            ),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 80.0,
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
            iconSize: 30.0,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book_fill),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark_border,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.flame),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: kSelectColor,
            onTap: _onItemTapped,
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
