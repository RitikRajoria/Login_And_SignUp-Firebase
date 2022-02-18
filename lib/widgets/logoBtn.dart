import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget logoBtn(context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        height: 80,
        width: deviceWidth * 0.43,
        decoration: BoxDecoration(
          color: Color(0xff171717),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2.5,
            color: const Color.fromARGB(100, 42, 42, 42),
            style: BorderStyle.solid,
          ),
        ),
        child: SvgPicture.asset(
          "assets/images/apple.svg",
          color: Colors.white,
          fit: BoxFit.scaleDown,
        ),
      ),
      Container(
        height: 80,
        width: deviceWidth * 0.43,
        decoration: BoxDecoration(
          color: Color(0xff171717),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2.5,
            color: const Color.fromARGB(100, 42, 42, 42),
            style: BorderStyle.solid,
          ),
        ),
        child: SvgPicture.asset(
          "assets/images/google.svg",
          fit: BoxFit.scaleDown,
          color: Colors.white,
        ),
      ),
    ],
  );
}