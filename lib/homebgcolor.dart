import 'package:emmaus/constants.dart';
import 'package:flutter/material.dart';

Color bgColor = kBodyColor;
bool isUser = false;

void trueUser() {
  bgColor = kBodyColor;
  isUser = false;
  print(bgColor.toString());
}

void falseUser() {
  bgColor = kUserBodyColor;
  isUser = true;
  print(bgColor.toString());
}

Color getColor() {
  return bgColor;
}

bool getUser() {
  return isUser;
}
