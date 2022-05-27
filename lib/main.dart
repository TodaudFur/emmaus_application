import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:emmaus/vardata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'myhomepage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification?.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String routeFromMessage = "";

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin.cancelAll();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getToken().then((value) => tokenInit(value!));

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification?.body);
        print(message.notification?.title);

        Get.defaultDialog(
            title: message.notification!.title!,
            content: Text(
              message.notification!.body!,
              style: const TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      routeFromMessage = message.data["route"];
      //print("onMessageOpenedApp");
      //print(routeFromMessage);
      _launchURL(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    autoLogin();
    // VarData().getNews();
    VarData().showBulletin();
    VarData().getHomeImage();

    if (routeFromMessage != "") {}
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emmaus',
        theme: ThemeData(
          primaryColor: kBodyColor,
          scaffoldBackgroundColor: kBodyColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AnimatedSplashScreen(
          duration: 500,
          splash: const Image(
            image: AssetImage('images/logo_em2_txt.png'),
          ),
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        ));
  }

  _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool al = prefs.getBool("autologin")!;
    print(al);
    if (al && VarData().getLogin() == false) {
      String id = prefs.getString("autoid")!;
      String pwd = prefs.getString("autopwd")!;
      VarData().post(id, pwd).then((value) {
        if (value) {
          Navigator.of(context)
              .pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false)
              .then((value) => setState(() {}));
        } else {}
      }).catchError((onError) {});
    }
  }

  tokenInit(String token) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    print(deviceInfo.deviceInfo);
    String userPhone = "";
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      print("android : ${androidInfo.androidId}");
      userPhone = androidInfo.androidId!;
    } else {
      final iosInfo = await deviceInfo.iosInfo;
      print("ios : ${iosInfo.name}");
    }
    var url = Uri.parse(
        'https://www.official-emmaus.com/g5/bbs/emmaus_firebase_token_init.php');
    var result =
        await http.post(url, body: {"userPhone": userPhone, "token": token});

    print(result.body);
  }
}
