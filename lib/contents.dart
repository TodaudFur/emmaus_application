import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';
import 'homebgcolor.dart';

class Contents extends StatefulWidget {
  @override
  _Contents createState() => _Contents();
}

class _Contents extends State<Contents> {
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
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          child: IconButton(
                              icon: Icon(
                                CupertinoIcons.barcode_viewfinder,
                                size: 45,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                      Divider(
                        color: kBodyColor,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "SHOW\nYOUR WORSHIP",
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
                              Icon(
                                CupertinoIcons.flame,
                                size: 40.0,
                              ),
                              Icon(
                                CupertinoIcons.flame,
                                size: 40.0,
                              ),
                              Icon(
                                CupertinoIcons.flame,
                                size: 40.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
                              Icon(
                                CupertinoIcons.book,
                                size: 50.0,
                              ),
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
