import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart';
import 'homebgcolor.dart';

class DetailScreen extends StatefulWidget {
  final item;
  DetailScreen(this.item);
  @override
  _DetailScreenState createState() => _DetailScreenState(item);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.item);

  final item;

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.arrow_left)),
          ),
          Expanded(
            child: Hero(
              tag: item,
              child: InteractiveViewer(
                panEnabled: false,
                boundaryMargin: EdgeInsets.all(0),
                minScale: 1,
                maxScale: 3,
                child: CachedNetworkImage(
                  imageUrl: item,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: MediaQuery.of(context).size.width + _scaleFactor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Bulletin extends StatefulWidget {
  @override
  _BulletinState createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> newsSliders = imgList
        .map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(item);
              }));
            },
            child: Hero(
              tag: item,
              child: CachedNetworkImage(
                imageUrl: item,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        )
        .toList();
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
}
