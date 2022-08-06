import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:mpd_telekom/screens/onboarding/onboarding_step1.dart';

import '../../elements/screen_templates.dart';

const String STEP_1_DESCRIPTION =
    "To strengthen your network security, we will update your router software and set all setting to highest security.";

const String STEP_2_DESCRIPTION =
    "Work devices require the highest security. We will create two separate networks on your router, one to work hard, one to play hard.";

const String STEP_3_DESCRIPTION =
    "To complete the setup, please choose your work devices to transfer them to your business network.";

class OnboardingOverviewScreen2 extends StatelessWidget {
  const OnboardingOverviewScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 30.0),
                child: Column(children: const [
                  H1("Give your WiFi superpowers with three simple steps",
                      color: Colors.white),
                  Infobox(
                      "We are setting up your home network for an optimal and secure home office experience."),
                  SizedBox(height: 20),
                  SetupBox(),
                  Spacer(),
                  BottomButton(),
                ]))));
  }
}

class SetupBox extends StatefulWidget {
  const SetupBox({Key? key}) : super(key: key);

  @override
  State<SetupBox> createState() => _SetupBoxState();
}

class _SetupBoxState extends State<SetupBox> {
  int expanded = 0;

  void setExpanded(int index) {
    setState(() => expanded = index);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Column(children: [
              SetupStep(
                  index: 1,
                  initiallyExpanded: expanded == 1,
                  setSelectedCallback: setExpanded,
                  title: "Optimizing network security and performance",
                  description: STEP_1_DESCRIPTION),
              SetupStep(
                  index: 2,
                  initiallyExpanded: expanded == 2,
                  setSelectedCallback: setExpanded,
                  title: "Create business WiFi network",
                  description: STEP_2_DESCRIPTION),
              SetupStep(
                  index: 3,
                  initiallyExpanded: expanded == 3,
                  setSelectedCallback: setExpanded,
                  title: "Choose your work devices",
                  description: STEP_3_DESCRIPTION),
            ])));
  }
}

class SetupStep extends StatelessWidget {
  final int index;
  final bool initiallyExpanded;
  final Function setSelectedCallback;
  final String title;
  final String description;

  const SetupStep({
    Key? key,
    required this.index,
    required this.setSelectedCallback,
    required this.initiallyExpanded,
    required this.title,
    required this.description,
  }) : super(key: key);

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey expansionTileKey = GlobalKey();
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: MyColors.lightBlue),
                child: Center(
                  child: Text("$index",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            tilePadding: const EdgeInsets.all(10),
            title: Text(title, style: const TextStyle(fontSize: 16)),
            textColor: Colors.black,
            key: expansionTileKey,
            initiallyExpanded: initiallyExpanded,
            onExpansionChanged: (value) {
              if (value) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey);
                setSelectedCallback(index);
              } else {
                setSelectedCallback(0);
              }
            },
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 70, top: 15, bottom: 15, right: 25),
                child: Text(description, style: const TextStyle(fontSize: 16)),
              )
            ]));
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: MyColors.lightBlue,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingStep1()),
            ),
        child: const Text("Let's go!",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            )));
  }
}
