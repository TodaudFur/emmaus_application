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
                                        '예배 안내',
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
                                        '주일 예배',
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
                                        ' - 일요일 14:00 / 2층 성전',
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
                                        '워라밸 금요성령대망회',
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
                                        ' - 금요일 21:00 / 5층 요한 성전',
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
                                        '섬기는 사람들',
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
                                                '담임목사 ',
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
                                                '주정빈 목사',
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
                                                '  교역자 ',
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
                                                '오광성 목사',
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
                                                '부장장로 ',
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
                                                '문기홍 장로',
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
                                                '회장 ',
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
                                                '김기수 ',
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
                                                '팀총무 ',
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
                                                '김찬희 ',
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
                                                '예배R&D ',
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
                                                '김주훈 ',
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
                                                '회계 ',
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
                                                '최동훈 ',
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
                                                '셀총무 ',
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
                                                '김도형 ',
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
                                                '교육R&D ',
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
                                                '진보배 ',
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
                                                '서기 ',
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
                                                '나소영 ',
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
                                                '강현서 ',
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
                                                '순전한 ',
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
                                                '김기수 ',
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
                                                '브레쉬트 ',
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
                                                '이지현 ',
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
                                              '새가족 ',
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
                                              '서예나 ',
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
                                              '김형빈 ',
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
                                              '섬김 ',
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
                                              '박재민 ',
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
                                              '이한솔 ',
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
                                              '참.미.콘 ',
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
                                              '김성수 ',
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
                                              '나소영 ',
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
