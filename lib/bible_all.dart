import 'package:emmaus/constants.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BibleAll extends StatefulWidget {
  @override
  _BibleAllState createState() => _BibleAllState();
}

class _BibleAllState extends State<BibleAll> {
  List<dynamic> date = [];
  List<dynamic> chapter = [];
  List<dynamic> count = [];
  List<dynamic> isCheck = [];

  @override
  void initState() {
    VarData().getAllBible().then((value) {
      print(value['isCheck']);
      setState(() {
        date = value['date'];
        chapter = value['chapter'];
        count = value['count'];
        isCheck = value['isCheck'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: Text(
                  "통독표",
                  style: TextStyle(
                    fontFamily: 'Nanum',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: date.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                date[index],
                                style: TextStyle(
                                  fontFamily: 'Nanum',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${chapter[index]} ${count[index]}",
                                style: TextStyle(
                                  fontFamily: 'Nanum',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Checkbox(
                              onChanged: (bool value) {},
                              value: isCheck[index] == null ? false : true,
                              activeColor: kSelectColor,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black.withOpacity(0.1)))),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
