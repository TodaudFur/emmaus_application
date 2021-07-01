import 'dart:typed_data';
import 'dart:ui';
import 'package:emmaus/constants.dart';
import 'package:emmaus/vardata.dart';
import 'package:emmaus/versedata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayVerse extends StatefulWidget {
  @override
  _TodayVerseState createState() => _TodayVerseState();
}

class _TodayVerseState extends State<TodayVerse> {
  Uint8List _imageFile;
  final _screenshotController = ScreenshotController();

  Future<bool> _requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      print('Storage permission is granted.');
      return true;
    } else {
      print('Storage permission is not granted.');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _reloadVerse();
    });
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 8, child: Container()),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      CupertinoIcons.square_arrow_down,
                      color: Colors.grey,
                    ),
                    onPressed: _takeScreenshot,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Screenshot(
              controller: _screenshotController,
              child: Container(
                color: kBodyColor,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                          Expanded(
                            flex: 6,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                VerseData().getEnglish(),
                                style: TextStyle(
                                  fontFamily: 'Mapo',
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Expanded(flex: 5, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(),
                            flex: 4,
                          ),
                          Expanded(
                            flex: 5,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                VerseData().getKorean(),
                                style: TextStyle(
                                  fontFamily: 'Mapo',
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                    Expanded(flex: 2, child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _reloadVerse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.get("verseDateKey");

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      VerseData().renew();
      await prefs.setString('verseDateKey', toDayDate);
      await prefs.setInt('verseNum', VerseData().getNum());
    } else {
      VerseData().putNum(prefs.getInt('verseNum'));
    }
  }

  void _takeScreenshot() async {
    _requestPermission();
    _imageFile = null;
    _screenshotController
        .capture(delay: Duration(milliseconds: 30))
        .then((Uint8List image) async {
      _imageFile = image;
      final result = await ImageGallerySaver.saveImage(image,
              quality: 60,
              name:
                  DateFormat("yyyy_MM_dd").format(DateTime.now()).toString()) +
          "Emmaus";
      print(result);
    }).catchError((onError) {
      print(onError);
    });
    Fluttertoast.showToast(
        msg: "사진이 저장되었습니다!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
}
/*final uint8List = await _screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List);
    await Share.shareFiles([file.path]);
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(uint8List),
        quality: 60,
        name: "hello");
    print(result);*/
