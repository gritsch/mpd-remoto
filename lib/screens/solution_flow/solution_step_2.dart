import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/elements/screen_templates.dart';

import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../main/home.dart';
import 'solution_step_2a_optimizing_testing.dart';

class Step2_Optimize extends StatelessWidget {
  final String eval = "ok";
  const Step2_Optimize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
      child: IntrinsicWidth(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 30),
          const H1("2. Get rid of\nbottlenecks", color: MyColors.white),
          const Infobox(
              "Old devices can slow down your network. This affects the internet experience on Herbert’s notebook."),
          const SizedBox(height: 40),
          const Icon(Icons.phonelink_erase, size: 120),
          const SizedBox(height: 20),
          const Center(
              child: Text("Solution",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))),
          const T1(
              "We temporarily optimize your network for the internet experience on Herbert’s notebook.    "),
          const ExceptionBox(
            "Old devices will temporarily be disconnected from the internet!",
          ),
          const Spacer(),
          CupertinoButton(
            color: MyColors.lightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OptimizeRouter()),
            ),
            child: const Text("Yes, let's go",
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
                MaterialPageRoute(
                  builder: (context) => const Home(),
                )),
            child: const Text("Skip this step",
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
