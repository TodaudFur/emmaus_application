import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart';
import 'homebgcolor.dart';

final List<String> imgList = [];

class Bulletin extends StatefulWidget {
  @override
  _BulletinState createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> newsSliders = imgList
      .map(
        (item) => Image.network(item),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    _showBulletin();

    return SafeArea(
      child: Container(
        color: getColor(),
        padding:
            EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 7.0, bottom: 12.0, left: 9.0, right: 9.0),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Image.asset("images/logo_ema.png"),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container(child: _showDate())),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: CarouselSlider(
                  items: newsSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDate() {
    String date = VarData().getBulletinDate();
    int t = int.parse(date);
    int y = t ~/ 10000;
    int m = (t % 10000) ~/ 100;
    int d = t % 100;

    return Text(
      y.toString() + "/" + m.toString() + "/" + d.toString() + " 주보",
      style: TextStyle(
        fontFamily: 'Noto',
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
      ),
    );
  }

  _showBulletin() {
    String date = VarData().getBulletinDate();
    int count = VarData().getBulletinNum();

    for (int i = 0; i < count; i++) {
      String url =
          "https://www.official-emmaus.com/g5/bbs/bulletin/$date" + "_$i.png";

      imgList.add(url);
    }
  }
}
