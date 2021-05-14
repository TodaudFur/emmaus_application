import 'dart:typed_data';
import 'dart:ui';
import 'package:emmaus/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0, right: 40),
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.square_arrow_down,
                  color: Colors.grey,
                ),
                onPressed: _takeScreenshot,
              ),
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
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            bottom: 80.0, right: 30.0, top: 40.0, left: 30.0),
                        child: Text(
                          'For this is the reason\nthe gospel was preached even to\nthose who are now dead,\n'
                          'so that they might be judged\naccording to men in regard to the body,\n'
                          'but live according to God\nin regard to the spirit.\n\n'
                          '1 Peter 4:6',
                          style: TextStyle(
                            fontFamily: 'Mapo',
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(bottom: 80.0, right: 30.0),
                        child: Text(
                          '이를 위하여\n죽은 자들에게도\n복음이 전파되었으니\n이는 육체로는\n사람으로 심판을 받으나\n영으로는 하나님을 따라\n살게 하려 함이라\n\n'
                          '베드로전서 4장 6절',
                          style: TextStyle(
                            fontFamily: 'Mapo',
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _takeScreenshot() async {
    _requestPermission();
    _imageFile = null;
    _screenshotController
        .capture(delay: Duration(milliseconds: 30))
        .then((Uint8List image) async {
      _imageFile = image;
      /*showDialog(
        context: context,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("CAPURED SCREENSHOT"),
          ),
          body: Center(
              child: Column(
                children: [
                  _imageFile != null
                      ? Image.memory(_imageFile)
                      : Container(),
                ],
              )),
        ),
      );*/
      final result = await ImageGallerySaver.saveImage(image,
          quality: 60,
          name: DateFormat("yyyy_MM_dd").format(DateTime.now()).toString());
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
