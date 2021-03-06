import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:emmaus/data/model/worship_date.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = 'https://official-emmaus.com/g5/bbs';

class FreController extends GetxController {
  @override
  void onInit() async {
    getWorshipDate();
    prefs = await SharedPreferences.getInstance();
    lastVisitDate = prefs.getString("lastDate22Summer")!;
    checkCount = prefs.getInt("22SummerCount");
    ticketCount = prefs.getInt("22SummerTicket");
    super.onInit();
  }

  late SharedPreferences prefs;
  String lastVisitDate = "";

  final _worshipDates = <WorshipDateModel>[].obs;
  List<WorshipDateModel> get worshipDates => _worshipDates;
  set worshipDates(val) => _worshipDates.value = val;

  final _checkCount = 0.obs;
  get checkCount => _checkCount.value;
  set checkCount(val) => _checkCount.value = val;

  final _ticketCount = 0.obs;
  get ticketCount => _ticketCount.value;
  set ticketCount(val) => _ticketCount.value = val;

  final confettiController =
      ConfettiController(duration: const Duration(seconds: 10));

  getWorshipDate() async {
    try {
      var map = <String, dynamic>{};
      final response =
          await http.post(Uri.parse('$baseUrl/emmaus_fre_date.php'), body: map);
      print("Get Worship Date Response : ${response.body}");
      if (response.statusCode == 200) {
        worshipDates = parseResponse(response.body);
      }
    } catch (e) {
      print("exception : $e");
      worshipDates = <WorshipDateModel>[];
    }
  }

  static List<WorshipDateModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<WorshipDateModel>((json) => WorshipDateModel.fromJson(json))
        .toList();
  }

  final _tokenList = <dynamic>[].obs;
  List<dynamic> get tokenList => _tokenList;
  set tokenList(val) => _tokenList.value = val;

  getFirebaseToken() async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/emmaus_firebase_token_select.php'),
          body: {});
      print("Get Firebase Token Response : ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        tokenList = body['token'];
      }
    } catch (e) {
      print("exception : $e");
    }
  }

  increaseCount() async {
    print(checkCount);
    if (checkCount < 17) {
      checkCount++;
      await prefs.setInt("22SummerCount", checkCount);
      if (checkCount == 17) {
        increaseTicket();
        confettiController.play();
        Future.delayed(const Duration(seconds: 30), () {
          confettiController.stop();
        });
      }
    }
  }

  increaseTicket() async {
    ticketCount++;
    await prefs.setInt("22SummerTicket", checkCount);
  }

  worshipCheck() async {
    if (int.parse(DateFormat("yyyyMMdd").format(DateTime.now())) > 20220630) {
      Fluttertoast.showToast(
          msg: "22 ?????? E-???????????? ????????? ???????????????.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      if (lastVisitDate != DateFormat("yyyyMMdd").format(DateTime.now())) {
        print("lastVisitDate : $lastVisitDate");
        print(DateFormat("yyyyMMdd").format(DateTime.now()));
        if (worshipDates
            .where((element) =>
                element.date == DateFormat("yyyyMMdd").format(DateTime.now()) &&
                element.startTime <=
                    int.parse(DateFormat("HHmm").format(DateTime.now())) &&
                element.endTime >=
                    int.parse(DateFormat("HHmm").format(DateTime.now())))
            .isNotEmpty) {
          print(int.parse(DateFormat("HHmm").format(DateTime.now())));
          await prefs.setString(
              'mDateKeyWinter', DateFormat("yyyyMMdd").format(DateTime.now()));

          lastVisitDate = DateFormat("yyyyMMdd").format(DateTime.now());
          prefs.setString("lastDate22Summer", lastVisitDate);
          increaseCount();
          Fluttertoast.showToast(
              msg: "E-???????????? ?????? ??????!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        } else {
          print(int.parse(DateFormat("HHmm").format(DateTime.now())));

          Fluttertoast.showToast(
              msg: "?????? ?????? ????????? ????????????!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "????????? ?????? ?????????????????????!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
  }
}
