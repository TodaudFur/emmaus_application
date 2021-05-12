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
        splash: Image(
          image: AssetImage('images/blue_emmaus_logo.jpg'),
        ),
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
