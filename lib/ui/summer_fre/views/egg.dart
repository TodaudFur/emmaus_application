import 'package:emmaus/constants.dart';
import 'package:emmaus/controller/fre_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Egg extends StatefulWidget {
  const Egg({Key? key}) : super(key: key);

  @override
  _EggState createState() => _EggState();
}

class _EggState extends State<Egg> {
  int eggCount = 0;

  final freController = Get.find<FreController>();

  @override
  void initState() {
    eggInit();
    super.initState();
  }

  @override
  void dispose() {
    eggSave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBodyColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Text(
            eggCount.toString() + "/1530000",
            style: const TextStyle(fontSize: 50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                minHeight: 100,
                value: eggCount / 1530000,
                color: const Color(0xFFffd79a),
                backgroundColor: Colors.grey.shade300,
                semanticsLabel: eggCount.toString() + "/1530000",
                semanticsValue: eggCount.toString() + "/1530000",
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: IconButton(
                onPressed: () {
                  eggCounting();
                },
                splashColor: const Color(0xFFffd79a),
                iconSize: MediaQuery.of(context).size.width,
                icon: const Icon(
                  Icons.egg_outlined,
                  color: Color(0xFFffd79a),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  eggInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      eggCount = prefs.getInt("eggCount") ?? 0;
    });
  }

  eggSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("eggCount", eggCount);
  }

  eggCounting() {
    setState(() {
      eggCount++;
    });
    if (eggCount == 1530000 ||
        eggCount == 30000 ||
        eggCount == 600000 ||
        eggCount == 90000 ||
        eggCount == 120000) {
      freController.increaseCount();
      Fluttertoast.showToast(
          msg: "E-프리퀀시 체크 성공!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}
