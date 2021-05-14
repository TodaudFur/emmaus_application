import 'package:flutter/cupertino.dart';
import 'constants.dart';

int specialNum = 0;
int normalNum = 3;

List<Widget> _iconList = [
  kFalseSpecial,
  kFalseSpecial,
  kFalseSpecial,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
  kFalseNormal,
];

List<String> _answerSpecialList = ["special1", "special2", "special3"];

List<String> _answerNormalList = [
  "normal1",
  "normal2",
  "normal3",
  "normal4",
  "normal5",
  "normal6"
];

class VarData {
  bool setIcon(String s) {
    if (s == _answerNormalList[normalNum - 3]) {
      _iconList[normalNum] = kTrueNormal;
      if (normalNum < 8) normalNum++;
      return true;
    } else {
      if (s == _answerSpecialList[specialNum]) {
        _iconList[specialNum] = kTrueSpecial;
        if (specialNum < 2) specialNum++;
        return true;
      } else {
        return false;
      }
    }
  }

  Widget getData(int i) {
    return _iconList[i];
  }
}
