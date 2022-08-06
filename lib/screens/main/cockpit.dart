import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/screens/solution_flow/problem_overview.dart';
import 'package:provider/provider.dart';

import '../../elements/screen_templates.dart';
import '../../providers/devices.dart';

class Cockpit extends StatefulWidget {
  const Cockpit({Key? key}) : super(key: key);

  @override
  State<Cockpit> createState() => _CockpitState();
}

class _CockpitState extends State<Cockpit> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
        child: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<DeviceModel>(
                builder: (context, deviceModel, child) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      double direction;
                      if (child.key == const ValueKey(301)) {
                        direction = 1.0;
                      } else {
                        direction = -1.0;
                      }
                      final offsetAnimation = Tween<Offset>(
                              begin: Offset(direction, 0.0),
                              end: const Offset(0.0, 0.0))
                          .animate(animation);
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                    child: deviceModel.anyProblems()
                        ? const DashboardWithIssue(key: ValueKey(301))
                        : const DashboardNoIssue(key: ValueKey(302))),
              ),
              const SizedBox(height: 30),
              const DevicesList("Your Work Devices"),
              const SizedBox(height: 30),
              const ConnectionsList(),
            ],
          ),
        ),
      ),
    ));
  }
}

class ConnectionsList extends StatefulWidget {
  const ConnectionsList({
    Key? key,
  }) : super(key: key);

  @override
  State<ConnectionsList> createState() => _ConnectionsListState();
}

class _ConnectionsListState extends State<ConnectionsList>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  DeviceStatus internetStatus = DeviceStatus.ok;
  DeviceStatus intranetStatus = DeviceStatus.ok;
  DeviceStatus vpnStatus = DeviceStatus.ok;
  DeviceStatus routerStatus = DeviceStatus.ok;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
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

  DeviceStatus allConnectionsAreOk() {
    if (internetStatus == DeviceStatus.ok &&
        intranetStatus == DeviceStatus.ok) {
      return DeviceStatus.ok;
    } else if (internetStatus == DeviceStatus.error ||
        intranetStatus == DeviceStatus.error) {
      return DeviceStatus.error;
    } else {
      return DeviceStatus.unknown;
    }
  }

  DeviceStatus allSecurityAreOk() {
    if (vpnStatus == DeviceStatus.ok && routerStatus == DeviceStatus.ok) {
      return DeviceStatus.ok;
    } else if (vpnStatus == DeviceStatus.error ||
        routerStatus == DeviceStatus.error) {
      return DeviceStatus.error;
    } else {
      return DeviceStatus.unknown;
    }
  }

  DeviceStatus _nextStatus(DeviceStatus status) {
    var size = DeviceStatus.values.length;
    var nextStatus = DeviceStatus.values[(status.index + 1) % size];
    return nextStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTitle("Security",
          animation: animation,
          animationOffset: 4,
          getStatus: allSecurityAreOk,
          filled: true,
          okIcon: Icons.shield_outlined,
          okIconFilled: Icons.shield),
      Center(
          child: Material(
              elevation: 3,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                  width: 340,
                  height: 128,
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => {
                                setState(
                                    () => {vpnStatus = _nextStatus(vpnStatus)})
                              },
                          child: ListTile(
                              leading: const Icon(Icons.vpn_lock),
                              title: const Text("VPN"),
                              trailing: AnimatedCheckmarkIcon(
                                  status: animation.value < 3
                                      ? DeviceStatus.unknown
                                      : vpnStatus,
                                  okIcon: Icons.shield_outlined,
                                  okIconFilled: Icons.shield))),
                      const Divider(),
                      GestureDetector(
                          onTap: () => {
                                setState(() =>
                                    {routerStatus = _nextStatus(routerStatus)})
                              },
                          child: ListTile(
                              leading: const Icon(Icons.router),
                              title: const Text("Router"),
                              trailing: AnimatedCheckmarkIcon(
                                  status: animation.value < 4
                                      ? DeviceStatus.unknown
                                      : routerStatus,
                                  okIcon: Icons.shield_outlined,
                                  okIconFilled: Icons.shield))),
                    ],
                  )))),
    ]);
  }
}

class ListTitle extends StatelessWidget {
  final Animation<double> animation;
  final double animationOffset;
  final String title;
  final Function getStatus;
  final bool filled;
  final IconData okIcon;
  final IconData okIconFilled;

  const ListTitle(this.title,
      {Key? key,
      required this.animation,
      required this.getStatus,
      required this.animationOffset,
      this.filled = true,
      this.okIcon = Icons.check_circle_outline,
      this.okIconFilled = Icons.check_circle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: MyColors.darkBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 5),
          AnimatedCheckmarkIcon(
            status: animation.value < animationOffset
                ? DeviceStatus.unknown
                : getStatus(),
            filled: filled,
            okIcon: okIcon,
            okIconFilled: okIconFilled,
          )
        ],
      ),
    );
  }
}

class AnimatedCheckmarkIcon extends StatelessWidget {
  final DeviceStatus status;
  final bool filled;
  final IconData okIcon;
  final IconData okIconFilled;
  final double size;

  const AnimatedCheckmarkIcon({
    Key? key,
    required this.status,
    this.filled = false,
    this.okIcon = Icons.check_circle_outline,
    this.okIconFilled = Icons.check_circle,
    this.size = 24,
  }) : super(key: key);

  Icon getIconFromStatus(DeviceStatus status) {
    switch (status) {
      case DeviceStatus.unknown:
        return const Icon(Icons.circle,
            color: MyColors.grey, size: 10, key: ValueKey(1));
      case DeviceStatus.ok:
        return Icon(filled ? okIconFilled : okIcon,
            color: Colors.green, key: const ValueKey(2), size: size);
      case DeviceStatus.error:
        return Icon(filled ? Icons.error : Icons.error_outline,
            color: Colors.red, key: const ValueKey(3), size: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: getIconFromStatus(status),
        ),
      ),
    );
  }
}

class DevicesList extends StatefulWidget {
  final String title;

  const DevicesList(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  State<DevicesList> createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesList>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  DeviceStatus deviceStatus1 = DeviceStatus.ok;
  DeviceStatus deviceStatus2 = DeviceStatus.ok;
  DeviceStatus deviceStatus3 = DeviceStatus.ok;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 4, end: 8).animate(controller)
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
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20.0),
        child: Consumer<DeviceModel>(
          builder: (context, deviceModel, child) => Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: MyColors.darkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              AnimatedCheckmarkIcon(
                  status: animation.value < 7
                      ? DeviceStatus.unknown
                      : deviceModel.getConnectionStatus(),
                  filled: true),
              const SizedBox(width: 3),
              AnimatedCheckmarkIcon(
                  status: animation.value < 7
                      ? DeviceStatus.unknown
                      : deviceModel.getSecurityStatus(),
                  filled: true,
                  okIcon: Icons.shield_outlined,
                  okIconFilled: Icons.shield),
            ],
          ),
        ),
      ),
      Center(
          child: Material(
              elevation: 3,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                  width: 340,
                  height: 422,
                  child: Column(
                    children: [
                      DeviceEntry(
                          deviceIndex: 0,
                          animation: animation,
                          animationOffset: 5),
                      const Divider(),
                      DeviceEntry(
                          deviceIndex: 1,
                          animation: animation,
                          animationOffset: 6),
                      const Divider(),
                      DeviceEntry(
                          deviceIndex: 2,
                          animation: animation,
                          animationOffset: 7),
                    ],
                  )))),
    ]);
  }
}

class DeviceEntry extends StatelessWidget {
  final int deviceIndex;
  final Animation<double> animation;
  final int animationOffset;

  const DeviceEntry({
    Key? key,
    required this.deviceIndex,
    required this.animation,
    this.animationOffset = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceModel>(builder: (context, deviceModel, child) {
      var device = deviceModel.getDevice(deviceIndex);
      return SizedBox(
        width: 340,
        height: 130,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  device.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Image.asset(device.iconPath)),
                )),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () =>
                            deviceModel.toggleDeviceSecurityStatus(deviceIndex),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Secure",
                                style: TextStyle(fontSize: 12)),
                            AnimatedCheckmarkIcon(
                                status: animation.value < animationOffset
                                    ? DeviceStatus.unknown
                                    : device.securityStatus,
                                okIcon: Icons.shield_outlined,
                                okIconFilled: Icons.shield,
                                size: 20)
                          ],
                        )),
                    GestureDetector(
                      onTap: () =>
                          deviceModel.toggleDeviceConnectionStatus(deviceIndex),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Connected",
                              style: TextStyle(fontSize: 12)),
                          AnimatedCheckmarkIcon(
                              status: animation.value < animationOffset + 0.33
                                  ? DeviceStatus.unknown
                                  : device.connectionStatus,
                              size: 20)
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () => deviceModel
                            .toggleDevicePerformanceStatus(deviceIndex),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Performance",
                                style: TextStyle(fontSize: 12)),
                            AnimatedCheckmarkIcon(
                                status: animation.value < animationOffset + 0.66
                                    ? DeviceStatus.unknown
                                    : device.performanceStatus,
                                okIcon: Icons.speed,
                                okIconFilled: Icons.speed,
                                size: 20)
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class DashboardNoIssue extends StatelessWidget {
  static const biggerStyle = TextStyle(
      color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 24);
  static const smallerStyle = TextStyle(
      color: MyColors.grey, fontWeight: FontWeight.bold, fontSize: 12);

  const DashboardNoIssue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: SizedBox(
          height: 200,
          width: 350,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 14),
            const GreenStatus(),
            const Text("You are ready for work", style: biggerStyle),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.calendar_month),
                SizedBox(width: 7),
                Text("Next meeting in 26 minutes"),
              ],
            )
          ])),
    ));
  }
}

class DashboardWithIssue extends StatelessWidget {
  static const biggerStyle = TextStyle(
      color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 24);
  static const smallerStyle = TextStyle(
      color: MyColors.grey, fontWeight: FontWeight.bold, fontSize: 12);

  const DashboardWithIssue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 200,
            width: 350,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: MyColors.white,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 14),
              const YellowStatus(),
              const Text("Network Issue Detected", style: biggerStyle),
              const SizedBox(height: 15),
              FittedBox(
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.amber,
                  elevation: 5,
                  //color: Colors.amber,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const ProblemOverview())),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("1 Problem",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: MyColors.white)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios,
                              color: MyColors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }
}

class GreenStatus extends StatelessWidget {
  const GreenStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: FittedBox(
          fit: BoxFit.fitHeight, child: Image.asset("assets/status_green.png")),
    );
  }
}

class YellowStatus extends StatelessWidget {
  const YellowStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Image.asset("assets/status_yellow.png")),
    );
  }
}
