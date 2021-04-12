import 'package:flutter/material.dart';

class HeaderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20.0, left: 20.0),
        alignment: Alignment.center,
        child: Text(
          'M Talk',
          style: TextStyle(
            fontFamily: 'Noto',
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ));
  }
}
