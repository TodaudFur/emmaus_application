import 'package:emmaus/constants.dart';
import 'package:flutter/material.dart';

import 'headertile.dart';
import 'message.dart';
import 'messagetile.dart';

final List<Message> message = [
  Message('러브라디오', 'DJ엠마오'),
  Message('찬양에 빠질 시간', '찬읽남'),
];

class Alarm extends StatelessWidget {
  const Alarm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MessageTile> messageTile = [];
    for (int i = 0; i < message.length; i++) {
      messageTile.add(MessageTile(message[i]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: HeaderTile(),
        ),
        Divider(
          color: kBodyColor,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 5.0,
          ),
          child: Text(
            'LIVE',
            style: TextStyle(
              fontFamily: 'Noto',
              fontWeight: FontWeight.w800,
              fontSize: 18.0,
              color: Colors.red,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 170.0,
            child: ListView(
              padding: EdgeInsets.only(right: 20.0, left: 10.0),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  width: 300.0,
                ),
                VerticalDivider(
                  color: kBodyColor,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                  width: 300.0,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: ListView.separated(
            itemCount: messageTile.length,
            itemBuilder: (BuildContext context, int index) {
              return messageTile[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ],
    );
  }
}
