import 'package:flutter/material.dart';
import 'constants.dart';
import 'myhomepage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:url_launcher/url_launcher.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    _scheduleWeeklyMondayTenAMNotification();
    _scheduleWeeklyFridayTenAMNotification();
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
        '예배 15분전입니다.',
        _nextInstanceOfMondayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'sw', 'sundayWorship', 'sundayWorship'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfMondayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    while (scheduledDate.weekday != DateTime.sunday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 13, 45);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _scheduleWeeklyFridayTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        '워라벨 성령대망회',
        '예배 15분전입니다.',
        _nextInstanceOfFridayTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'fw', 'fridayWorship', 'fridayWorship'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  tz.TZDateTime _nextInstanceOfFridayTenAM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfNinePM();
    while (scheduledDate.weekday != DateTime.friday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfNinePM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 45);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
