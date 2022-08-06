import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:mpd_telekom/screens/onboarding/onboarding_overview.dart';
import 'package:mpd_telekom/screens/onboarding/onboarding_step2.dart';

import '../../elements/screen_templates.dart';

class OnboardingStep1 extends StatefulWidget {
  const OnboardingStep1({Key? key}) : super(key: key);

  @override
  State<OnboardingStep1> createState() => _OnboardingStep1State();
}

class _OnboardingStep1State extends State<OnboardingStep1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
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
                child: Column(children: [
                  const SizedBox(height: 30),
                  const H1("Step 1:\nFast & Bullet-proof", color: Colors.white),
                  const Infobox(STEP_1_DESCRIPTION),
                  const SizedBox(height: 140),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: (animation.value < 3.0)
                        ? const LoadingAnimation()
                        : const Icon(Icons.check_circle_outline,
                            size: 100, color: Colors.green),
                  ),
                  const SizedBox(height: 50),
                  InternetWaypointBar(animation.value),
                  const Spacer(),
                  (animation.value < 2.0)
                      ? const BottomButtonDisabled()
                      : const BottomButton(),
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

class InternetWaypointBar extends StatelessWidget {
  final double activeWaypoint;

  const InternetWaypointBar(this.activeWaypoint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InternetWaypoint(
              text: "Updating security",
              icon: Icons.shield_outlined,
              active: activeWaypoint >= 1),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Optimizing performance",
              icon: Icons.speed,
              active: activeWaypoint >= 2),
        ],
      ),
    );
  }
}

/// Find all available icons here:
/// https://api.flutter.dev/flutter/material/Icons-class.html
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
              MaterialPageRoute(builder: (context) => const OnboardingStep2()),
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
