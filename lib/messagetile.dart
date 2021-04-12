import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class MessageTile extends StatelessWidget {
  MessageTile(this._person);

  final Message _person;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        height: 50.0,
        width: 50.0,
      ),
      title: Text(
        _person.title,
        style: TextStyle(fontFamily: 'Noto', fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        _person.description,
        style: TextStyle(fontFamily: 'Noto', fontWeight: FontWeight.w600),
      ),
    );
  }
}
