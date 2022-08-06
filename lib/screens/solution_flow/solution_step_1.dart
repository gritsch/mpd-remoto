import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/elements/screen_templates.dart';
import 'package:mpd_telekom/screens/solution_flow/checking_connection.dart';
import 'package:mpd_telekom/screens/solution_flow/solution_step_2.dart';

import '../../constants/colors.dart';
import '../../constants/styles.dart';

class Step1_Loc extends StatelessWidget {
  const Step1_Loc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
      child: IntrinsicWidth(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 50),
          const H1("1. Change Location", color: MyColors.white),
          const Infobox(
              "Your internet experience strongly depends on your distance to the router. "
              "Also, walls and floors can affect your WiFi connection."),
          const SizedBox(height: 20),
          const WiFiMap(),
          const SizedBox(height: 10),
          const Text("Solution",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          const T1(
              "Move closer to your router to have \nmore stable internet. "),
          const Spacer(),
          CupertinoButton(
            color: MyColors.lightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CheckingConnection()),
            ),
            child: const Text("I have moved",
                style: TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            color: MyColors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Step2_Optimize()),
            ),
            child: const Text("Can't move right now",
                style: TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ]),
      ),
    )));
  }
}

class WiFiMap extends StatelessWidget {
  const WiFiMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    alignment: FractionalOffset.center,
                    image: AssetImage("assets/wifi_map.png"))
                //    child: FittedBox(
                //    fit: BoxFit.fitHeight, child: Image.asset("assets/wohnzimmer.jpg")),
                )));
  }
}
