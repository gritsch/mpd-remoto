import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/mockup.dart';

import '../../constants/styles.dart';
import '../../elements/screen_templates.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Center(
                    child: H1("Manage your work devices", color: Colors.white)),
                Infobox(
                    "Devices can only be added or removed from your secure business network via this app"),
                SizedBox(height: 10),
                DeviceList(),
                Center(child: AddDeviceButton()),
              ]),
        ),
      ),
    ));
  }
}

class AddDeviceButton extends StatelessWidget {
  static const double borderRadius = 20;
  static const Color color = MyColors.lightBlue;
  static void noop() => {};

  const AddDeviceButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: const InkWell(
          customBorder: CircleBorder(),
          onTap: noop,
          child: Icon(
            Icons.add,
            color: MyColors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class DeviceList extends StatelessWidget {
  final double height;
  final bool scrollable;

  const DeviceList({Key? key, this.height: 270, this.scrollable: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: 3,
            physics:
                scrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (_, index) => Card(
                    child: ListTile(
                  leading: MockupDevices.deviceImages[index],
                  title: Text(MockupDevices.deviceNames[index]),
                  subtitle: Text(MockupDevices.deviceLastOnlines[index]),
                  trailing: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                ))));
  }
}
