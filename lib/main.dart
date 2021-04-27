import 'package:flutter/material.dart';
import 'constants.dart';
import 'myhomepage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emmaus',
      theme: ThemeData(
        primaryColor: kBodyColor,
        scaffoldBackgroundColor: kBodyColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        duration: 2000,
        splash: Column(
          children: [
            Image(
              image: AssetImage('images/emmaus_logo.png'),
              color: Color(0xFF16056b),
              height: 65,
            ),
            Text(
              'Emmaus',
              style: TextStyle(
                color: Color(0xFF16056b),
                fontSize: 10.0,
                fontFamily: 'Noto',
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
