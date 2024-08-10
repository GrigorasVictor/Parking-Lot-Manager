import 'package:flutter/material.dart';

const backgroundColor = 0xFF33404F;
const itemColor = 0xFFFFFFFF;
const itemColorHighlighted = 0xFF00DDA3;
const itemColorHighlightedTransparent = 0x3300DDA3;

const double paddingValue = 19;
double? fontSize;

void setScreenWidth(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  fontSize = screenWidth * 0.10;
}


