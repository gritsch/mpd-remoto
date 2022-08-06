import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';

import '../../elements/screen_templates.dart';

class SetupConfiguration extends StatelessWidget {
  const SetupConfiguration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 30.0),
                child: Column(children: const [
                  H1("Get your home network ready for work in three simple steps",
                      color: Colors.white),
                  Infobox(
                      "We are setting up your home network for an optimal and secure home office experience."),
                  SizedBox(height: 30),
                  SetupBox(children: [
                    SetupStep(
                        index: 1,
                        title: "Updating network security and performance",
                        description:
                            "To strengthen your network security, we will update your router software and set all setting to highest security."),
                    SetupStep(
                        index: 2,
                        title: "Create business WiFi network",
                        description:
                            "To separate work from your private life, we will create two different networks that run on the same router. The business network is set to the strictest access settings."),
                    SetupStep(
                        index: 3,
                        title: "Choose your work devices",
                        description:
                            "To complete the setup, choose which devices should be transferred automatically to the business network."),
                  ]),
                  Spacer(),
                  BottomButton(),
                ]))));
  }
}

class SetupBox extends StatelessWidget {
  final List<Widget> children;

  const SetupBox({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Column(children: children)));
  }
}

class SetupStep extends StatelessWidget {
  final int index;
  final String title;
  final String description;

  const SetupStep({
    Key? key,
    required this.index,
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
            onExpansionChanged: (value) {
              if (value) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey);
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
              MaterialPageRoute(
                  builder: (context) => const SetupConfiguration()),
            ),
        child: const Text("Let's go!",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            )));
  }
}
