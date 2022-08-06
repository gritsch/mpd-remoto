import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';

import '../main/home.dart';
import "solution_step_2.dart";

class ConnectionEvaluation extends StatelessWidget {
  final String conn_type;

  const ConnectionEvaluation(this.conn_type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ResultBox(conn_type));
  }
}

class ResultBox extends StatelessWidget {
  final String conn_type;

  static const Map content = {
    "ok": {
      "headline": "You have solved all issues!",
      "icon": Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
      "button": "Got it",
      "next": Home()
    },
    "warn": {
      "headline": "Herbert's notebook still has unstable connection",
      "icon": Icon(Icons.error_outline, size: 100, color: MyColors.darkYellow),
      "button": "Try other solution",
      "next": Step2_Optimize()
    },
  };

  const ResultBox(this.conn_type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 150.0, horizontal: 30.0),
        child: Material(
            elevation: 2,
            color: MyColors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: Container(
                decoration: BoxDecoration(
                  color: MyColors.white,
                  // Red border with the width is equal to 5
                  border: Border.all(width: 2, color: MyColors.lightBlue),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              content[conn_type]["headline"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: MyColors.darkBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: content[conn_type]["icon"],
                          ),
                          const Spacer(),
                          Center(
                            child: CupertinoButton(
                              color: MyColors.lightBlue,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                (route) => false,
                              ),
                              child: Text(content[conn_type]["button"],
                                  style: const TextStyle(
                                    color: MyColors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ])))));
  }
}
