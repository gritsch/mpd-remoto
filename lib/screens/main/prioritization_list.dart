import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/mockup.dart';

import '../../constants/styles.dart';
import '../../elements/screen_templates.dart';

class PrioritizationList extends StatelessWidget {
  const PrioritizationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
            child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(children: const [
        H1("Your devices perform when you rely on it.", color: Colors.white),
        PrioritizationDropTarget(),
        DeviceListDraggable()
      ]),
    )));
  }
}

class PrioritizationDropTarget extends StatefulWidget {
  const PrioritizationDropTarget({Key? key}) : super(key: key);

  @override
  State<PrioritizationDropTarget> createState() =>
      _PrioritizationDropTargetState();
}

class _PrioritizationDropTargetState extends State<PrioritizationDropTarget> {
  String? deviceName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => setState(() => deviceName = null),
      child: DragTarget(
        builder: (context, candidateData, rejectedData) {
          if (deviceName == null) {
            return const PrioritizationDrop();
          } else {
            return PrioritizationDropWithCard(deviceName!);
          }
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          deviceName = data as String;
        },
      ),
    );
  }
}

class PrioritizationDrop extends StatelessWidget {
  const PrioritizationDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 2,
        color: MyColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: SizedBox(
          width: 330,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline,
                        color: MyColors.darkBlue, size: 30),
                    const SizedBox(width: 35),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Drag device here to prioritize",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Warning: This can affect the quality on other devices in your network!",
                            style: TextStyle(color: MyColors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class PrioritizationDropWithCard extends StatelessWidget {
  final String deviceName;

  const PrioritizationDropWithCard(
    this.deviceName, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 100,
          width: 330,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: MyColors.white,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: const Icon(Icons.star),
                title: Text(deviceName),
                trailing: const Icon(Icons.arrow_circle_right),
              ),
            ),
          )),
    );
  }
}

class DeviceListDraggable extends StatelessWidget {
  const DeviceListDraggable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: const [
          DeviceListEntryDraggable(MockupDevices.deviceName1),
          DeviceListEntryDraggable(MockupDevices.deviceName2,
              icon: MockupDevices.deviceIcon2),
          DeviceListEntryDraggable(MockupDevices.deviceName3,
              icon: MockupDevices.deviceIcon3),
          DeviceListEntryDraggable(MockupDevices.deviceName4),
        ],
      ),
    );
  }
}

class DeviceListEntryDraggable extends StatelessWidget {
  final String deviceName;
  final IconData icon;

  const DeviceListEntryDraggable(this.deviceName,
      {Key? key, this.icon = Icons.phone_android})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: DeviceListEntry(deviceName, icon: icon),
      data: deviceName,
      child: DeviceListEntry(deviceName, icon: icon),
    );
  }
}

class DeviceListEntry extends StatelessWidget {
  final String deviceName;
  final IconData icon;

  const DeviceListEntry(this.deviceName,
      {Key? key, this.icon = Icons.phone_android})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(deviceName),
          subtitle: const Text("Last active: today"),
          trailing: const Icon(Icons.menu),
        ),
      ),
    );
  }
}
