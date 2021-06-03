import 'dart:io';

import 'package:emmaus/main.dart';
import 'package:emmaus/myhomepage.dart';
import 'package:emmaus/vardata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';
import 'homebgcolor.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DataSource calendarData = _getCalendarDataSource();
  String agendaText = "엠마오 일정";
  String name = "엠마오";
  Widget content = Container();
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    setState(() {
      name = VarData().getName();
      content = VarData().getContent();
    });
    return SafeArea(
      child: Container(
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
                  child: Text(
                    'EMMAUS',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
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
                              '안녕하세요 ',
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
                            name,
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
                              '님',
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
                        flex: 7,
                        child: Container(),
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
                /*Spacer(),
                FlatButton(
                  onPressed: () {

                    setState(() {
                      if (getUser()) {
                        trueUser();
                        agendaText = "엠마오 일정";
                      } else {
                        falseUser();
                        agendaText = "개인 일정";
                      }
                    });
                  },
                  child: Icon(Icons.ac_unit),
                ),*/
              ],
            ),
            Expanded(
              flex: 2,
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
                  child: content,
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
              height: 30.0,
            ),
            Expanded(
              flex: 8,
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
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SfCalendar(
                      view: CalendarView.month,
                      dataSource: _getCalendarDataSource(),
                      headerStyle: CalendarHeaderStyle(
                        textStyle: TextStyle(
                            fontFamily: 'Noto', fontWeight: FontWeight.w900),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                          dayTextStyle: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      )),
                      monthViewSettings: MonthViewSettings(
                        showAgenda: false,
                        monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(color: Color(0xFF111111)),
                          leadingDatesTextStyle:
                              TextStyle(color: Color(0x15111111)),
                          trailingDatesTextStyle:
                              TextStyle(color: Color(0x15111111)),
                        ),
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment,
                      ),
                      cellBorderColor: Colors.white,
                      todayHighlightColor: kSelectColor,
                      selectionDecoration: BoxDecoration(
                        border: Border.all(color: kSelectColor, width: 1),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    File mainImage = File('$path/qrcode.png');

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

                          imageCache.clear();
                          final File newImage =
                              await _image.copy('$path/qrcode.png');

                          setState(() {
                            mainImage = newImage;
                          });

                          Fluttertoast.showToast(
                              msg: "QR코드가 저장이 되었습니다!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "수정",
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
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "돌아가기",
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
          msg: "QR코드가 저장이 되었습니다!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  final DateTime day = DateTime(DateTime.now().year, 5, 20, 9);
  /*appointments.add(Appointment(
    startTime: day,
    endTime: day.add(Duration(hours: 2)),
    isAllDay: true,
    subject: 'Meeting',
    color: Colors.blue,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(DateTime.now().year, 4, 28, 9),
    endTime: DateTime(DateTime.now().year, 4, 28, 9).add(Duration(hours: 2)),
    isAllDay: true,
    subject: 'Meeting',
    color: Colors.blue,
    startTimeZone: '',
    endTimeZone: '',
  ));*/

  return DataSource(appointments);
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
    Key key,
    this.text,
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
/*Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '공지사항',
                        style: TextStyle(
                          fontFamily: 'Noto',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Divider(
                      color: kBodyColor,
                    ),
                    Container(
                      height: 170.0,
                      child: ListView(
                        padding: EdgeInsets.only(right: 20.0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 50.0,
                      color: kBodyColor,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '예배 소식',
                        style: TextStyle(
                          fontFamily: 'Noto',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Divider(
                      color: kBodyColor,
                    ),
                    Container(
                      height: 170.0,
                      child: ListView(
                        padding: EdgeInsets.only(right: 20.0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                          VerticalDivider(
                            color: kBodyColor,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            height: 170.0,
                            width: 120.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
