import 'package:flutter/material.dart';

import 'colors.dart';

class MyTextStyles {
  static const t1 = TextStyle(fontSize: 16, color: MyColors.grey);
}

class H1 extends StatelessWidget {
  final String text;
  final Color color;

  const H1(this.text, {Key? key, this.color = MyColors.darkBlue})
      : super(key: key);

  TextStyle _build_style({Color color = MyColors.darkBlue}) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: Text(
        text,
        style: _build_style(color: color),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class T1 extends StatelessWidget {
  final String text;
  final Color color;

  const T1(this.text, {Key? key, this.color = MyColors.grey}) : super(key: key);

  TextStyle _build_style({Color color = MyColors.grey}) {
    return TextStyle(fontSize: 16, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(text,
          style: _build_style(color: color), textAlign: TextAlign.center),
    );
  }
}
