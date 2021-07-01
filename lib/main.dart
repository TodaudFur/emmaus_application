import 'package:emmaus/vardata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'myhomepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:package_info/package_info.dart';

Future onSelectNotification(String payload) async {
  const url = 'https://youtube.com/channel/UChKWnwNuFsgzZ1pIwVnPCvA';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_noti_icon');

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);

  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _requestPermissions();
    _configureLocalTimeZone();

    super.initState();
    _scheduleWeeklyMondayTenAMNotification();
    _scheduleWeeklyFridayTenAMNotification();

    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.body);
        print(message.notification.title);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      print("onMessageOpenedApp");
      print(routeFromMessage);
      _launchURL(routeFromMessage);
    });
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
        );
  }

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
            image: AssetImage('images/logo_em2_txt.png'),
          ),
          nextScreen: MyHomePage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
        ));
  }

  Future<void> _scheduleWeeklyMondayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        '주일 예배',
        '예배 10분전입니다.',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'sw', 'sundayWorship', 'sundayWorship'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    print("주일예배 알림");
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.sunday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    print("next sunday");
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    tz.initializeTimeZones();
    //final seoul = tz.getLocation('Asia/Seoul');
    //final tz.TZDateTime now = tz.TZDateTime.now(seoul);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print(now);
    //tz.TZDateTime scheduledDate =
    //    tz.TZDateTime(seoul, now.year, now.month, now.day, 13, 50);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 4, 50);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    print("next time");
    return scheduledDate;
  }

  Future<void> _scheduleWeeklyFridayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        '워라밸 성령대망회',
        '예배 10분전입니다.',
        _nextInstanceOfFridayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'fw', 'fridayWorship', 'fridayWorship'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
    print("금요철야 알림");
  }

  tz.TZDateTime _nextInstanceOfFridayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfNinePM();
    while (scheduledDate.weekday != DateTime.friday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfNinePM() {
    tz.initializeTimeZones();
    //final seoul = tz.getLocation('Asia/Seoul');
    //final tz.TZDateTime now = tz.TZDateTime.now(seoul);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    //tz.TZDateTime scheduledDate =
    //    tz.TZDateTime(seoul, now.year, now.month, now.day, 20, 50);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11, 50);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }

  _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
