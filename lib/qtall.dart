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
            Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 3, child: Container()),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        DateTime.now().year.toString(),
                        style: TextStyle(
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 5, child: Container()),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xFFf0c653),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "${DateTime.now().month}월",
                            style: TextStyle(
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 5, child: Container()),
                ],
              ),
            ),

            Expanded(
              flex: 6,
              child: GridView.builder(
                  itemCount: 31,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1, //item 의 가로
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    bool isCheck = false;
                    if (list.isNotEmpty) {
                      if (int.parse(list[0].toString().substring(6, 8)) ==
                          index + 1) {
                        list.removeAt(0);
                        isCheck = true;
                        print("wow : $index");
                      }
                    }
                    return Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              backgroundColor:
                                  isCheck ? Color(0xFFf0c653) : kBodyColor,
                              child: Padding(
                                padding: index < 9
                                    ? EdgeInsets.all(4.7)
                                    : EdgeInsets.all(2),
                                child: FittedBox(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nanum',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                              child: isCheck
                                  ? Image.asset("images/book.png")
                                  : Image.asset("images/empty.png"))
                        ],
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.black.withOpacity(0.1)))),
                    );
                  }),
            ),
            Expanded(flex: 4, child: Container()),

            // Expanded(
            //   flex: 10,
            //   child: (list.length == 0)
            //       ? Container(
            //           child: Text("큐티 기록 없음"),
            //         )
            //       : Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: GridView.builder(
            //               gridDelegate:
            //                   const SliverGridDelegateWithMaxCrossAxisExtent(
            //                 childAspectRatio: 3 / 2,
            //                 crossAxisSpacing: 4,
            //                 mainAxisSpacing: 40,
            //                 maxCrossAxisExtent: 100,
            //               ),
            //               itemCount: list.length,
            //               itemBuilder: (BuildContext ctx, index) {
            //                 String s =
            //                     "${list[index].toString().substring(4, 6)}/${list[index].toString().substring(6, 8)}";
            //
            //                 return Container(
            //                   decoration: BoxDecoration(
            //                       color: kSelectColor.withOpacity(0.3),
            //                       borderRadius: BorderRadius.circular(15)),
            //                   alignment: Alignment.center,
            //                   child: Text(
            //                     "$s\n큐티출석 완료!",
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       color: Colors.black87,
            //                     ),
            //                   ),
            //                 );
            //               }),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
