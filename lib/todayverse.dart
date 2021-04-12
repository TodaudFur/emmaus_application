import 'package:flutter/material.dart';

class TodayVerse extends StatelessWidget {
  const TodayVerse({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  bottom: 80.0, right: 30.0, top: 80.0, left: 30.0),
              child: Text(
                'For this is the reason\nthe gospel was preached even to\nthose who are now dead,\n'
                'so that they might be judged\naccording to men in regard to the body,\n'
                'but live according to God\nin regard to the spirit.\n\n'
                '1 Peter 4:6',
                style: TextStyle(
                  fontFamily: 'Mapo',
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: 80.0, right: 30.0),
              child: Text(
                '이를 위하여\n죽은 자들에게도\n복음이 전파되었으니\n이는 육체로는\n사람으로 심판을 받으나\n영으로는 하나님을 따라\n살게 하려 함이라\n\n'
                '베드로전서 4장 6절',
                style: TextStyle(
                  fontFamily: 'Mapo',
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
