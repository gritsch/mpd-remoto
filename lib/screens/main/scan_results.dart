import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/mockup.dart';
import 'package:mpd_telekom/screens/main/loading_screen.dart';

import '../../constants/styles.dart';
import '../../elements/screen_templates.dart';

class ScanResults extends StatelessWidget {
  const ScanResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Center(
                    child:
                        H1("Your network.\nYour rules.", color: Colors.white)),
                const Infobox(
                    "This is an overview of all devices in your network. Suspicious devices were automatically flagged and can be banned by you."),
                const DeviceList(),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10.0),
                  child: Center(
                      child: Text("Last updated 2 minutes ago",
                          style: TextStyle(color: MyColors.grey))),
                ),
                Center(
                  child: CupertinoButton(
                      color: MyColors.lightBlue,
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => const LoadingScreen()),
                          ),
                      child: const Text("Scan now",
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.bold))),
                ),
              ]),
        ),
      ),
    ));
  }
}

class DeviceList extends StatelessWidget {
  final double height;
  final bool scrollable;

  const DeviceList({Key? key, this.height: 300, this.scrollable: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: MockupDevices.deviceNames.length,
            physics:
                scrollable ? ScrollPhysics() : NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (_, index) => Card(
                    child: ListTile(
                  leading: Icon(MockupDevices.deviceIcons[index]),
                  title: Text(MockupDevices.deviceNames[index]),
                  trailing: MockupDevices.deviceIconsTrailing[index],
                ))));
  }
}
