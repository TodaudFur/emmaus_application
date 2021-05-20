import 'package:emmaus/vardata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'EMMAUS',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Noto',
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '안녕하세요 ',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      ' 님',
                      style: TextStyle(
                        fontFamily: 'Noto',
                        fontWeight: FontWeight.w900,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
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
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  final DateTime day = DateTime(DateTime.now().year, 5, 20, 9);
  appointments.add(Appointment(
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
  ));

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
