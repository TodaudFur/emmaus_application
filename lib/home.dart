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
  @override
  Widget build(BuildContext context) {
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
                    'e',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.yellow[700],
                      fontFamily: 'Noto',
                    ),
                  ),
                  Text(
                    'MMAUS',
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
                Text(
                  'Hi Kim',
                  style: TextStyle(
                    fontFamily: 'Noto',
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                Spacer(),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (getUser()) {
                        trueUser();
                      } else {
                        falseUser();
                      }
                    });
                  },
                  child: Icon(Icons.ac_unit),
                ),
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
                  child: Text(
                    'Today: Friday Worship',
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    ),
                  ),
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
                      dataSource: MeetingDataSource(),
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