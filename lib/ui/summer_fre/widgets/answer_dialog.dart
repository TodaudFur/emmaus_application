import 'dart:convert';

import 'package:emmaus/controller/fre_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../vardata.dart';

class AnswerDialog extends StatefulWidget {
  const AnswerDialog({Key? key}) : super(key: key);

  @override
  _AnswerDialogState createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog> {
  String question = "";
  int tryTime = 2;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    questionInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SystemChrome.setEnabledSystemUIOverlays([]);
      },
      child: AlertDialog(
        title: const Text(
          "문제 풀기",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Noto',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '문제 : $question',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'Noto',
                ),
              ),
              Text(
                '(입력 기회 : $tryTime/2)',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontFamily: 'Noto',
                ),
              ),
              const Divider(),
              TextField(
                  onSubmitted: (String s) {
                    if (s.isNotEmpty) {
                      setState(() {
                        checkAnswer(s);
                        textController.text = "";
                      });
                    }
                  },
                  controller: textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '정답',
                  )),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              FlatButton(
                child: const Text('확인'),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    setState(() {
                      checkAnswer(textController.text);
                      textController.text = "";
                    });
                  }
                },
              ),
              FlatButton(
                child: const Text('취소'),
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
    );
  }

  questionInit() async {
    getQuestion();
    getTryTime();
  }

  getQuestion() async {
    String date = DateFormat("MMdd").format(DateTime.now()).toString();
    print(date);
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_fre_question.php');
    var result = await http.post(url, body: {
      "date": date,
    });
    print(result.body);
    Map<String, dynamic> body = json.decode(result.body);
    setState(() {
      question = body['question'];
    });
  }

  getTryTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String toDayDate = DateFormat('MMdd').format(DateTime.now());
    String lastVisitDate = prefs.getString("tryTimeDate22Summer") ?? "";

    if (toDayDate != lastVisitDate) {
      await prefs.setString('tryTimeDate22Summer', toDayDate);
      tryTime = 2;
    } else {
      setState(() {
        tryTime = prefs.getInt("tryTime22Summer") ?? 2;
      });
      print(tryTime);
    }
  }

  checkAnswer(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastVisitDate = prefs.getString("lastVisitDate22Summer") ?? "";

    String toDayDate = DateFormat('MMdd').format(DateTime.now());

    if (lastVisitDate != toDayDate) {
      VarData().check(s).then((value) async {
        if (value) {
          await prefs.setString('lastVisitDate22Summer', toDayDate);
          final freController = Get.find<FreController>();
          freController.increaseCount();
          Fluttertoast.showToast(
              msg: "정답입니다.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else {
          if (tryTime == 0) {
            Fluttertoast.showToast(
                msg: "정답 입력 기회를 다 사용했습니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          } else {
            setState(() {
              tryTime--;
            });
            await prefs.setInt('tryTime22Summer', tryTime);
            Fluttertoast.showToast(
                msg: "오답입니다!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        }
      }).catchError((onError) {
        print("Error");
      });
    } else {
      Fluttertoast.showToast(
          msg: "오늘의 문제는 이미 풀었습니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}
