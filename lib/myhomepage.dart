import 'dart:io';

import 'package:emmaus/bulletin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shake/shake.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Bulletin(),
    Text(
      'Oops!\nMADE BY 404',
      style: TextStyle(
        color: Colors.black26,
        fontSize: 50,
      ),
    ),
    TodayVerse(),
    Settings(),
  ];

  late File _image;
  final picker = ImagePicker();
  bool isOpen = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future getImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File mainImage = File('$path/qrcode.png');
    isOpen = true;

    if (await File('$path/qrcode.png').exists()) {
      showDialog(
        context: context,
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(mainImage),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: kBodyColor,
                        onPressed: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });

                          imageCache?.clear();
                          final File newImage =
                              await _image.copy('$path/qrcode.png');

                          setState(() {
                            mainImage = newImage;
                          });

                          Fluttertoast.showToast(
                              msg: "QR????????? ????????? ???????????????!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "??????",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: kBodyColor,
                        onPressed: () {
                          isOpen = false;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "????????????",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });

      final File newImage = await _image.copy('$path/qrcode.png');

      Fluttertoast.showToast(
          msg: "QR????????? ????????? ???????????????!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    ShakeDetector.autoStart(onPhoneShake: () {
      if (!isOpen) {
        print("shake!!!!");
        getImage();
      }
    });
    super.initState();
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
                  child: Tab(
                      icon: Image.asset(
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
                  label: '???',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.doc_text_fill),
                  label: '??????',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      null,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.book_fill),
                  label: '????????? ??????',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '?????????',
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
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
