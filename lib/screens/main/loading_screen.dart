import 'package:flutter/material.dart';

import 'package:loading_animations/loading_animations.dart';

import 'package:mpd_telekom/constants/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int activeWaypoint = 0;

  void nextWaypoint() {
    setState(() => activeWaypoint++);

    if (activeWaypoint > 3) {
      activeWaypoint = 0;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => nextWaypoint()),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Scanning for devices...'),
            backgroundColor: MyColors.lightBlue,
          ),
          backgroundColor: MyColors.white,
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Center(
              child: Text(
                "Scanning for devices...",
                style: TextStyle(
                    fontSize: 28,
                    color: MyColors.darkBlue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: LoadingBouncingGrid.square(
                  inverted: true,
                  size: 100,
                  backgroundColor: MyColors.darkBlue),
            ),
            const SizedBox(height: 100),
            InternetWaypointBar(activeWaypoint),
          ])),
    );
  }
}

class InternetWaypointBar extends StatelessWidget {
  final int activeWaypoint;

  const InternetWaypointBar(this.activeWaypoint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InternetWaypoint(
              text: "Discovering devices in your network",
              icon: Icons.device_hub,
              active: activeWaypoint == 1),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Analyzing devices",
              icon: Icons.wifi_find_outlined,
              active: activeWaypoint == 2),
          const RightArrowIcon(),
          InternetWaypoint(
              text: "Creating report",
              icon: Icons.phone_android,
              active: activeWaypoint == 3),
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
            child: Icon(icon, color: active ? Colors.black : Colors.white)),
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
