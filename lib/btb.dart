import 'dart:math';

import 'package:emmaus/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class BTB extends StatefulWidget {
  @override
  _BTBState createState() => _BTBState();
}

class _BTBState extends State<BTB> {
  Image brown = Image.asset("assets/btb/brown_button.png");
  Image grey = Image.asset("assets/btb/grey_button.png");
  List<Widget> tile;
  Timer _timer;
  int ch = 0;

  @override
  Widget build(BuildContext context) {
    double imgHeight = MediaQuery.of(context).size.height / 20;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/btb/background.png"),
                fit: BoxFit.fill),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 30),
                        child: Text(
                          'SCORE : 200',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.height / 30,
                            color: kSelectColor,
                          ),
                        ),
                      ),
                      Image.asset(
                        "assets/btb/line.png",
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: tile,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          onTapDown: (TapDownDetails tapDownDetails) {
                            print("tapDown");
                            setState(() {
                              brown = Image.asset(
                                  "assets/btb/brown_button_alt.png");
                            });
                          },
                          onTapUp: (TapUpDetails tapUpDetails) {
                            print("tapUp");
                            setState(() {
                              brown =
                                  Image.asset("assets/btb/brown_button.png");
                            });
                          },
                          child: brown),
                      GestureDetector(
                          onTap: () {},
                          onTapDown: (TapDownDetails tapDownDetails) {
                            print("tapDown");
                            setState(() {
                              grey =
                                  Image.asset("assets/btb/grey_button_alt.png");
                            });
                          },
                          onTapUp: (TapUpDetails tapUpDetails) {
                            print("tapUp");
                            setState(() {
                              grey = Image.asset("assets/btb/grey_button.png");
                            });
                          },
                          child: grey),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class brown_button extends StatelessWidget {
  const brown_button({
    Key key,
    @required this.imgHeight,
  }) : super(key: key);

  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/btb/brown_tile.png",
      height: imgHeight,
    );
  }
}

class grey_button extends StatelessWidget {
  const grey_button({
    Key key,
    @required this.imgHeight,
  }) : super(key: key);

  final double imgHeight;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/btb/grey_tile.png",
      height: imgHeight,
    );
  }
}

class Square extends PositionComponent {
  static const speed = 0.25;
  static const squareSize = 128.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  @override
  void render(Canvas c) {
    super.render(c);

    c.drawRect(size.toRect(), white);
    c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), red);
    c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    //angle %= 2 * math.pi;
  }

  @override
  void onMount() {
    super.onMount();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
  }
}

class MyGame extends BaseGame with DoubleTapDetector, TapDetector {
  bool running = true;

  @override
  Future<void> onLoad() async {
    add(
      Square()
        ..x = 100
        ..y = 100,
    );
  }

  @override
  void onTapUp(TapUpInfo info) {
    final touchArea = RectExtension.fromVector2Center(
      center: info.eventPosition.game,
      width: 20,
      height: 20,
    );

    final handled = components.any((c) {
      if (c is PositionComponent && c.toRect().overlaps(touchArea)) {
        components.remove(c);
        return true;
      }
      return false;
    });

    if (!handled) {
      add(Square()
        ..x = touchArea.left
        ..y = touchArea.top);
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }

    running = !running;
  }
}
