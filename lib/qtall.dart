import 'package:emmaus/constants.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QtAll extends StatefulWidget {
  @override
  _QtAllState createState() => _QtAllState();
}

class _QtAllState extends State<QtAll> {
  List<dynamic> list = [];

  @override
  void initState() {
    listInit();
    super.initState();
  }

  listInit() {
    VarData().getAllQt().then((value) {
      list = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(list);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Expanded(
              child: (list.length == 0)
                  ? Container(
                      child: Text("큐티 기록 없음"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 40,
                            maxCrossAxisExtent: 100,
                          ),
                          itemCount: list.length,
                          itemBuilder: (BuildContext ctx, index) {
                            String s =
                                "${list[index].toString().substring(4, 6)}/${list[index].toString().substring(6, 8)}";

                            return Container(
                              decoration: BoxDecoration(
                                  color: kSelectColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.center,
                              child: Text(
                                "$s\n큐티출석 완료!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
