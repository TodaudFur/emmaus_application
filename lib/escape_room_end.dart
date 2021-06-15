import 'package:emmaus/constants.dart';
import 'package:emmaus/game.dart';
import 'package:emmaus/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class EscapeRoomEnd extends StatefulWidget {
  @override
  _EscapeRoomEndState createState() => _EscapeRoomEndState();
}

class _EscapeRoomEndState extends State<EscapeRoomEnd> {
  ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag: 0.05,
                emissionFrequency: 0.01,
                numberOfParticles: 30,
                gravity: 0.05,
                shouldLoop: true,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '성공!',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      color: kSelectColor,
                      fontFamily: 'Noto',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: kSelectColor,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Game()),
                          );
                        },
                        child: Text(
                          "처음으로",
                          style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                      VerticalDivider(),
                      RaisedButton(
                        color: kSelectColor,
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Game()),
                          );
                        },
                        child: Text(
                          "초기화",
                          style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
