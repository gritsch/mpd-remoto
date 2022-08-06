import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/constants/mockup.dart';
import 'package:mpd_telekom/constants/styles.dart';
import 'package:mpd_telekom/screens/main/home.dart';

import '../elements/screen_templates.dart';

/* "Please scan the QR code below with your work devices to connect to the business WiFi. "
                    "Alternatively, you can connect to your business WiFi by visiting the WiFi settings"
                    " of your device, select the WiFi name below out of the available WiFi connections and "
                    "type in the password."*/

class BusinessSetup extends StatelessWidget {
  const BusinessSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWrapper(child: Padding(padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Center(child: H1('Add your work devices\nto your business WiFi', color: MyColors.white,)),
                const Infobox("Welcome to your business WiFi! Your work devices will be connected "
                    "to this WiFi for enhanced security of your work-related affairs."
                    ),
                WifiInfo()
              ]
          ))),
    );
  }
}


class WifiInfo extends StatelessWidget {
  static const font_size = 15.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Container(
            child: Column(
                children: [
                  Center(
                    child: Text("Please scan the QR code below with your work devices to connect to the business WiFi. "
                "Alternatively, visit the WiFi settings"
                " of your device, select the WiFi name below and "
                "type in the password.",
                    style: const TextStyle(fontSize: 12, color: MyColors.grey), textAlign: TextAlign.center,),
                    ),
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Material(
                      elevation: 3,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        width: 300,
                        height: 80,
                        child: Column(
                          children: [
                            Center(child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("WiFi Name:",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: font_size)),
                                Text("BUSINESS",
                                    style: const TextStyle(fontSize: font_size)),
                            ]))),
                            Divider(),
                            Center(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Password:",
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: font_size)),
                                      Text("dragon-fox!tool9pear?",
                                          style: const TextStyle(fontSize: font_size)),
                                    ]))),
                          ],
                        ))),
                  ),
                  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: CupertinoButton(
                            color: MyColors.lightBlue,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => const Home()),
                            ),
                            child: const Text("Done!",
                                style: TextStyle(
                                    color: MyColors.white,
                                    fontWeight: FontWeight.bold))),
                      )),
                ])
        ));
  }
}

