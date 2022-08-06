import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:provider/provider.dart';

import '../../elements/screen_templates.dart';
import '../../providers/devices.dart';
import 'connection_evaluation.dart';

class OptimizeRouter extends StatefulWidget {
  const OptimizeRouter({Key? key}) : super(key: key);

  @override
  State<OptimizeRouter> createState() => _OptimizeRouterState();
}

class _OptimizeRouterState extends State<OptimizeRouter>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 0, end: 4).animate(controller)
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
                  const H1("Removing slow devices...", color: Colors.white),
                  const Infobox(
                      "After 8 hours, the devices are automatically reconnected.\nYou can ban them permanently in the devices tab."),
                  const SizedBox(height: 140),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: (animation.value < 4.0)
                        ? const LoadingAnimation()
                        : const Icon(Icons.check_circle_outline,
                            size: 100, color: Colors.green),
                  ),
                  const SizedBox(height: 50),
                  InternetWaypointBar(animation.value),
                  const Spacer(),
                  (animation.value < 3.0)
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
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InternetWaypoint(
              text: "Changing router settings",
              icon: Icons.router,
              active: activeWaypoint >= 1),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Removing old devices",
              icon: Icons.phonelink_erase,
              active: activeWaypoint >= 2),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Running speed test",
              icon: Icons.speed,
              active: activeWaypoint >= 3),
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
    return Consumer<DeviceModel>(
        builder: (context, deviceModel, child) => CupertinoButton(
            color: MyColors.lightBlue,
            disabledColor: MyColors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            onPressed: () {
              deviceModel.fixIssue();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConnectionEvaluation("ok")),
              );
            },
            child: const Text("Next",
                style: TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                ))));
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
