import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/mockup.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:mpd_telekom/screens/main/home.dart';

import '../../elements/screen_templates.dart';
import 'onboarding_overview.dart';

class OnboardingStep3 extends StatefulWidget {
  const OnboardingStep3({Key? key}) : super(key: key);

  @override
  State<OnboardingStep3> createState() => _OnboardingStep3State();
}

class _OnboardingStep3State extends State<OnboardingStep3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  bool atLeastOneSelected = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0, end: 8).animate(controller)
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
                child: Column(children: [
                  const SizedBox(height: 30),
                  const H1("Step 3:\nOne more thing...", color: Colors.white),
                  const Infobox(STEP_3_DESCRIPTION),
                  const SizedBox(height: 40),
                  SelectableDeviceList(animation: animation),
                  const Spacer(),
                  animation.value >= 3
                      ? const BottomButton()
                      : const BottomButtonDisabled(),
                ]))));
  }
}

class SelectableDeviceList extends StatelessWidget {
  final Animation<double> animation;
  const SelectableDeviceList({Key? key, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 3,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: SizedBox(
            width: 330,
            child: Column(
              children: [
                SelectableDeviceEntry(index: 0, selected: animation.value >= 3),
                const Divider(),
                SelectableDeviceEntry(index: 1, selected: animation.value >= 8),
                const Divider(),
                SelectableDeviceEntry(index: 2, selected: animation.value >= 5),
                const Divider(),
                const SelectableDeviceEntry(index: 3, selected: false),
                const Divider(),
                const SelectableDeviceEntry(index: 4, selected: false),
              ],
            )));
  }
}

class SelectableDeviceEntry extends StatelessWidget {
  final int index;
  final bool selected;
  const SelectableDeviceEntry(
      {Key? key, required this.index, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //enabled: true,  // Mock it
      title: Text(MockupDevices.deviceNames[index],
          style: selected
              ? const TextStyle(fontWeight: FontWeight.bold)
              : const TextStyle()),
      leading: Icon(MockupDevices.deviceIcons[index]),
      trailing: selected
          ? const Icon(Icons.radio_button_checked)
          : const Icon(Icons.radio_button_off),
    );
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
        disabledColor: MyColors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (_) => false,
            ),
        child: const Text("Next",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            )));
  }
}

class BottomButtonDisabled extends StatelessWidget {
  const BottomButtonDisabled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoButton(
        color: MyColors.lightBlue,
        disabledColor: MyColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onPressed: null,
        child: Text("Next",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            )));
  }
}
