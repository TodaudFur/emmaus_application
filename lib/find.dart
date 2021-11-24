import 'dart:convert';

import 'package:emmaus/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Find extends StatefulWidget {
  Find(this.what);
  final what;
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  final idController = TextEditingController();
  final yearController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = true;
  bool isResult = false;
  Widget resultValue;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: isLoading
              ? isResult
                  ? resultValue
                  : widget.what == "id"
                      ? Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '이름',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: yearController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '기수',
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kSelectColor),
                                onPressed: () {
                                  setState(() {
                                    isLoading = false;
                                    getInfo(nameController.text,
                                        yearController.text, "");
                                  });
                                },
                                child: Text(
                                  "아이디 찾기",
                                  style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '이름',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: idController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ID',
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kSelectColor),
                                onPressed: () {
                                  setState(() {
                                    isLoading = false;
                                    getInfo(nameController.text, "",
                                        idController.text);
                                  });
                                },
                                child: Text(
                                  "비밀번호 초기화",
                                  style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
              : CircularProgressIndicator(),
        )),
      ),
    );
  }

  Future getInfo(String name, String year, String id) async {
    var url =
        Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_find.php');
    var result = await http.post(url, body: {
      "name": name,
      "year": year,
      "id": id,
      "what": widget.what,
    });

    print(result.body);

    if (widget.what == "id") {
      Map<String, dynamic> body = json.decode(result.body);
      resultValue = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "아이디는 ",
            style: TextStyle(fontSize: 14),
          ),
          Text(
            body['mb_id'],
            style: TextStyle(
                color: kSelectColor, fontWeight: FontWeight.w900, fontSize: 14),
          ),
          Text(
            "입니다",
            style: TextStyle(fontSize: 14),
          ),
        ],
      );
    } else {
      resultValue = Text("비밀번호가 초기화되었습니다 ( 비밀번호=아이디 )");
    }

    isResult = true;
    isLoading = true;
    setState(() {});
  }
}
