import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:mpd_telekom/screens/onboarding/onboarding_step3.dart';

import '../../elements/screen_templates.dart';
import 'onboarding_overview.dart';

class OnboardingStep2 extends StatefulWidget {
  const OnboardingStep2({Key? key}) : super(key: key);

  @override
  State<OnboardingStep2> createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends State<OnboardingStep2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 5).animate(controller)
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
                  const H1("Step 2:\nSeparate business from your personal life",
                      color: Colors.white),
                  const Infobox(STEP_2_DESCRIPTION),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: (animation.value < 2.0)
                          ? const SizedBox(
                              key: ValueKey(1),
                              width: 300,
                              height: 220,
                              child: Image(
                                  image: AssetImage('assets/wifi_split_1.jpg')))
                          : (animation.value < 3.0)
                              ? const SizedBox(
                                  key: ValueKey(2),
                                  width: 300,
                                  height: 220,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/wifi_split_2.jpg')))
                              : (animation.value < 4.0)
                                  ? const SizedBox(
                                      key: ValueKey(3),
                                      width: 300,
                                      height: 220,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/wifi_split_3.jpg')))
                                  : const SizedBox(
                                      height: 220,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Icon(Icons.check_circle_outline,
                                            size: 100, color: Colors.green),
                                      ),
                                    )),
                  const SizedBox(height: 50),
                  InternetWaypointBar(animation.value),
                  const Spacer(),
                  (animation.value < 3.0)
                      ? const BottomButtonDisabled()
                      : const BottomButton(),
                ]))));
  }
}

class InternetWaypointBar extends StatelessWidget {
  final double activeWaypoint;

  const InternetWaypointBar(this.activeWaypoint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InternetWaypoint(
              text: "Scanning for devices",
              icon: Icons.search,
              active: activeWaypoint >= 1),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Creating new networks",
              icon: Icons.add_circle_outline,
              active: activeWaypoint >= 2),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Removing old network",
              icon: Icons.remove_circle_outline,
              active: activeWaypoint >= 3),
        ],
      ),
    );
  }
}

class InternetWaypoint extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;

  const InternetWaypoint({
    Key? key,
    required this.text,
    required this.icon,
    this.active = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: active
                    ? Colors.green
                    : const Color.fromARGB(255, 220, 220, 220),
                shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white)),
        const SizedBox(height: 10),
        Container(
            constraints: const BoxConstraints(maxWidth: 90),
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    color: active ? Colors.black : MyColors.grey)))
      ],
    );
  }
}

class RightArrowIcon extends StatelessWidget {
  const RightArrowIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Icon(Icons.arrow_right, size: 30, color: MyColors.darkBlue),
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
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingStep3()),
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
