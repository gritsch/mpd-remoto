import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'connection_evaluation.dart';

import '../../elements/screen_templates.dart';

class CheckingConnection extends StatefulWidget {

  const CheckingConnection({Key? key}) : super(key: key);

  @override
  State<CheckingConnection> createState() => _CheckingConnectionState();
}

class _CheckingConnectionState extends State<CheckingConnection>
    with SingleTickerProviderStateMixin {
  static const String check = "warn";
  late Animation<double> animation;
  late AnimationController controller;



  @override
  void initState() {
    Timer(Duration(seconds: 4), (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          const ConnectionEvaluation(check)));
    });
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 3).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const H1("Checking \nyour connection", color: Colors.white),
                  const SizedBox(height: 140),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: (animation.value <= 2.0)
                        ? const LoadingAnimation()
                        : const Icon(Icons.check_circle_outline,
                        size: 100, color: Colors.green),
                  ),
                ]))));
  }
}

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingBouncingGrid.square(
          inverted: true, size: 100, backgroundColor: MyColors.darkBlue),
    );
  }
}

