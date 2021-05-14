import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'vardata.dart';
import 'constants.dart';
import 'homebgcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Contents extends StatefulWidget {
  @override
  _Contents createState() => _Contents();
}

class _Contents extends State<Contents> {
  final textController = TextEditingController();

  void _checkAnswer(String s) {
    if (VarData().setIcon(s)) {
      Fluttertoast.showToast(
          msg: "정답입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      SystemChrome.setEnabledSystemUIOverlays([]);
      Navigator.of(context).pop();
    } else {
      print("else");
      Fluttertoast.showToast(
          msg: "오답입니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  void _check() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                SystemChrome.setEnabledSystemUIOverlays([]);
              },
              child: new AlertDialog(
                title: new Text(
                  "정답",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Noto',
                  ),
                ),
                content: Container(
                  height: 110,
                  child: Column(
                    children: [
                      Text(
                        '정답은 소문자',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontFamily: 'Noto',
                        ),
                      ),
                      Divider(),
                      TextField(
                          onSubmitted: (String s) {
                            setState(() {
                              textController.text = "";
                              _checkAnswer(s);
                            });
                          },
                          controller: textController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hint',
                          )),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      FlatButton(
                        child: Text('확인'),
                        onPressed: () {
                          setState(() {
                            textController.text = "";
                            _checkAnswer(textController.text);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text('취소'),
                        onPressed: () {
                          textController.text = "";
                          SystemChrome.setEnabledSystemUIOverlays([]);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: getColor(),
        padding:
            EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'e',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.yellow[700],
                      fontFamily: 'Noto',
                    ),
                  ),
                  Text(
                    '-MMAUS',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 50.0,
            ),
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 30.0, top: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 15.0),
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.checkmark_rectangle,
                              size: 40,
                            ),
                            onPressed: _check,
                          ),
                        ),
                      ),
                      Divider(
                        color: kBodyColor,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "SHOW\nYOUR WORSHIP!",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 22.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        color: kBodyColor,
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5.0,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              VarData().getData(0),
                              VarData().getData(1),
                              VarData().getData(2),
                              VarData().getData(3),
                              VarData().getData(4),
                              VarData().getData(5),
                              VarData().getData(6),
                              VarData().getData(7),
                              VarData().getData(8),
                            ],
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
      ),
    );
  }
}
