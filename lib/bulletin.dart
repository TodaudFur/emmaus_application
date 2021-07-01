import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Bulletin extends StatefulWidget {
  @override
  _BulletinState createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.arrow_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    VerticalDivider(
                      color: kBodyColor,
                    ),
                    Text(
                      '주보',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _showBulletin(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _showBulletin() {
    String date = VarData().getBulletinDate();
    int count = VarData().getBulletinNum();

    List<Widget> image = [];

    image.add(VerticalDivider(
      color: kBodyColor,
    ));
    for (int i = 0; i < count; i++) {
      String url =
          "https://www.official-emmaus.com/g5/bbs/bulletin/$date" + "_$i.png";
      print(url);
      image.add(Image.network(
        url,
        width: MediaQuery.of(context).size.width - 10,
      ));
      image.add(VerticalDivider(
        color: kBodyColor,
      ));
    }

    return image;
  }
}
