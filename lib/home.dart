import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emmaus/bible_all.dart';
import 'package:emmaus/ui/summer_fre/summer_fre.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'creeds.dart';
import 'detail_screen.dart';
import 'homebgcolor.dart';

// class DetailScreen extends StatefulWidget {
//   final item;
//   DetailScreen(this.item);
//   @override
//   _DetailScreenState createState() => _DetailScreenState(item);
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   _DetailScreenState(this.item);
//
//   final item;
//
//   double _scaleFactor = 1.0;
//   double _baseScaleFactor = 1.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(CupertinoIcons.arrow_left)),
//             ),
//             Expanded(
//               child: Hero(
//                 tag: item,
//                 child: InteractiveViewer(
//                   panEnabled: true,
//                   boundaryMargin: EdgeInsets.all(0),
//                   minScale: 1,
//                   maxScale: 4,
//                   child: CachedNetworkImage(
//                     imageUrl: item,
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                     width: MediaQuery.of(context).size.width + _scaleFactor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

List<dynamic> eventFile = [];
List<dynamic> eventName = [];
List<dynamic> eventUrl = [];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String agendaText = "????????? ??????";
  String name = "?????????";
  Widget content = Container();
  late File _image;
  final picker = ImagePicker();
  bool isCheck = false;
  bool isOpen = false;
  bool isTong = false;
  String bible = "??????";

  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<Widget> newsSliders = [];

  @override
  void initState() {
    setState(() {
      newsSliders = imgList
          .map(
            (item) => GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return DetailScreen(
                    item: item,
                  );
                }));
              },
              child: Hero(
                tag: item,
                child: CachedNetworkImage(
                  imageUrl: item,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          )
          .toList();
    });
    if (eventName.isEmpty) {
      VarData().getEvents().then((value) {
        setState(() {
          eventFile = VarData().getEventFile();
          eventName = VarData().getEventName();
          eventUrl = VarData().getEventUrl();
        });
      });
    }
    VarData().getBible().then((value) {
      print(value);
      setState(() {
        bible = value[0];
        if (value[1] != null) {
          isTong = true;
        }
      });
    });
    super.initState();
  }

  void flutterDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              'EMMAUS',
              style: TextStyle(
                fontFamily: 'Noto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Creeds("????????????");
                      }));
                    },
                    child: Text(
                      "????????????",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Creeds("????????????");
                      }));
                    },
                    child: Text(
                      "????????????",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Creeds("????????????");
                      }));
                    },
                    child: Text(
                      "????????????",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSelectColor,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Creeds("????????????");
                      }));
                    },
                    child: Text(
                      "????????????",
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isCheck = VarData().getCheck();
      //print(isCheck);
    });
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: getColor(),
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FittedBox(
                  child: Image.asset("images/logo_ema.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '??????????????? ',
                              style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            VarData().getName(),
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '???',
                              style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            //Get.to(() => const MDrive());
                          },
                          //icon: Icon(CupertinoIcons.cloud_download),
                          icon: Container(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            flutterDialog();
                          },
                          icon: Icon(CupertinoIcons.doc_text_search),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: Icon(CupertinoIcons.qrcode),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: isTong
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: kSelectColor,
                                        ),
                                        onPressed: () {
                                          Get.to(BibleAll());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: FittedBox(child: Text("????????????")),
                                        ))
                                    : FittedBox(
                                        child: Text(
                                          "????????? ??????",
                                          style: TextStyle(
                                            fontFamily: 'Noto',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kSelectColor,
                                    ),
                                    onPressed: isTong
                                        ? null
                                        : () {
                                            if (DateTime.now().year == 2022) {
                                              if (VarData().getLogin()) {
                                                Get.dialog(
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    barrierDismissible: false);
                                                VarData()
                                                    .setBible()
                                                    .then((value) {
                                                  if (value) {
                                                    setState(() {
                                                      isTong = true;
                                                    });
                                                    Get.back();
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: "?????? ??????",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        fontSize: 16.0);
                                                  }
                                                });
                                              }
                                            }
                                          },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: FittedBox(
                                          child: Text(isTong ? "????????????" : bible)),
                                    ))),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FittedBox(
                                  child: Text(
                                    "????????? ?????? ??????",
                                    style: TextStyle(
                                      fontFamily: 'Noto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kSelectColor,
                                    ),
                                    onPressed: (VarData().getCheck())
                                        ? null
                                        : () {
                                            if (VarData().getLogin()) {
                                              qtCheck();
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.1),
                                                        content: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 150,
                                                              height: 150,
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "???????????? ????????????",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  fontSize: 16.0);
                                            }
                                          },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: FittedBox(
                                          child: Text((VarData().getCheck())
                                              ? "????????????"
                                              : "????????????")),
                                    ))),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 30.0,
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Align(
                    child: Stack(
                      children: [
                        Text(
                          '????????? ?????? ',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width,
                              color: kSelectColor.withOpacity(0.2),
                            )),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                          child: CarouselSlider(
                        items: newsSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      )),
                    ),
                  ),
                  Divider(
                    color: getColor(),
                  ),
                  Align(
                    child: Stack(
                      children: [
                        Text(
                          '????????? ????????? ',
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width,
                              color: kSelectColor.withOpacity(0.2),
                            )),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kSelectColor,
                          ),
                          onPressed: () {
                            if (VarData().getLogin()) {
                              if (DateTime.now()
                                  .isAfter(DateTime(2022, 6, 1))) {
                                Get.to(SummerFre());
                              } else {
                                Fluttertoast.showToast(
                                    msg: "????????? ????????????.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "????????? ??? ??????????????????.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text("2022 Summer E-????????????")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  Future getImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File mainImage = File('$path/qrcode.png');
    isOpen = true;

    if (await File('$path/qrcode.png').exists()) {
      showDialog(
        context: context,
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(mainImage),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: kBodyColor,
                        onPressed: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });

                          imageCache?.clear();
                          final File newImage =
                              await _image.copy('$path/qrcode.png');

                          setState(() {
                            mainImage = newImage;
                          });

                          Fluttertoast.showToast(
                              msg: "QR????????? ????????? ???????????????!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "??????",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        color: kBodyColor,
                        onPressed: () {
                          isOpen = false;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "????????????",
                          style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });

      final File newImage = await _image.copy('$path/qrcode.png');

      Fluttertoast.showToast(
          msg: "QR????????? ????????? ???????????????!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  qtCheck() async {
    print(VarData().getId());
    var url = Uri.parse('https://www.official-emmaus.com/g5/bbs/emmaus_qt.php');
    var result = await http.post(url, body: {"mb_id": VarData().getId()});

    print("reuslt");
    print(result.body);
    if (result.body == "true") {
      VarData().setCheck();
    }
    Navigator.of(context).pop();
    setState(() {});
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class CalendarText extends StatelessWidget {
  const CalendarText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Noto',
        fontWeight: FontWeight.w900,
        fontSize: 20.0,
        color: Color(0x15111111),
      ),
    );
  }
}
