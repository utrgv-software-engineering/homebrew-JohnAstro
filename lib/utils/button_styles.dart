import 'package:flutter/material.dart';

// Choose device buttons
// True curves the top corners
// False curves the bottom corners
ButtonStyle buttonStyleType(bool isTop) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F3F3)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: isTop
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)))),
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF4C748B)));
}

// Continue button style given state
ButtonStyle continueButtonStyle(bool state) {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(280, 46)),
      foregroundColor: state
          ? MaterialStateProperty.all<Color>(Color(0xFFFFFFFF))
          : MaterialStateProperty.all<Color>(Color(0xFF757474)),
      backgroundColor: state
          ? MaterialStateProperty.all<Color>(Color(0xFF4C748B))
          : MaterialStateProperty.all<Color>(Color(0xFFE2E2E2)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ));
}

// Button Style for the done button
ButtonStyle doneButtonStyle() {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(280, 46)),
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4C748B)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )));
}
