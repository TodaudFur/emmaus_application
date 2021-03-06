import 'package:cached_network_image/cached_network_image.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'detail_screen.dart';
import 'homebgcolor.dart';


class Bulletin extends StatefulWidget {
  const Bulletin({Key? key}) : super(key: key);

  @override
  _BulletinState createState() => _BulletinState();
}

class _BulletinState extends State<Bulletin> {
  final CarouselController _controller = CarouselController();
  List<Widget> newsSliders = [];
  @override
  void initState() {
    newsSliders = imgList
        .map(
          (item) => GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(item: item,);
          }));
        },
        child: Hero(
          tag: item,
          child: CachedNetworkImage(
            imageUrl: item,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        color: getColor(),
        padding:
            const EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0, bottom: 30.0),
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
                  boxShadow: const [
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
                      height: double.infinity,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 1 / 1,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {

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
      y.toString() + "/" + m.toString() + "/" + d.toString() + " ??????",
      style: const TextStyle(
        fontFamily: 'Noto',
        fontWeight: FontWeight.w700,
        fontSize: 15.0,
      ),
    );
  }
}
