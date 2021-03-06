import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'homebgcolor.dart';

class Emmaus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.arrow_left),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ),
            Divider(
              color: kBodyColor,
            ),
            Expanded(
              flex: 9,
              child: Container(
                color: getColor(),
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 100.0),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(flex: 3, child: Container()),
                              Expanded(
                                flex: 6,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Image.asset("images/logo_ema.png"),
                                ),
                              ),
                              Expanded(flex: 3, child: Container()),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '?????? ??????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Noto',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '?????? ??????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Noto',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        ' - ????????? 14:00 / 2??? ??????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Noto',
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '????????? ?????????????????????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Noto',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        ' - ????????? 21:00 / 5??? ?????? ??????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Noto',
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        '????????? ?????????',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Noto',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '???????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ??????',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '  ????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ??????',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '???????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ??????',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(flex: 5, child: Container()),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '?????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '?????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '  R&D ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 6,
                                    child: Container(),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                'ACTS ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '???????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Noto',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                '????????? ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Noto',
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              ' EMS ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '?????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              'P.S.A ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              'Makers ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '404 ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Noto',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '????????? ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Noto',
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
