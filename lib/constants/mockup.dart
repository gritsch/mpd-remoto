import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';

class MockupDevices {
  static const deviceName1 = "Herbert's notebook";
  static const deviceIcon1 = Icons.computer;
  static const deviceImage1 = SizedBox(
      width: 40,
      height: 40,
      child: Image(image: AssetImage('assets/macbook_icon2.png')));

  static const deviceName2 = "Herbert's smartphone";
  static const deviceIcon2 = Icons.phone_android;
  static const deviceImage2 = SizedBox(
      width: 40,
      height: 40,
      child: Image(image: AssetImage('assets/iphone_icon.png')));

  static const deviceName3 = "Herbert's tablet";
  static const deviceIcon3 = Icons.tablet_android;
  static const deviceImage3 = SizedBox(
      width: 40,
      height: 40,
      child: Image(image: AssetImage('assets/macbook_icon2.png')));

  static const deviceName4 = "Andrea's smartphone";
  static const deviceIcon4 = Icons.phone_android;

  static const deviceName5 = "Daniel's Playstation";
  static const deviceIcon5 = Icons.gamepad_outlined;

  static const deviceName6 = "Device XUA-192";
  static const deviceIcon6 = Icons.router;

  static const deviceNames = [
    deviceName1,
    deviceName2,
    deviceName3,
    deviceName4,
    deviceName5,
    deviceName6,
  ];
  static const deviceIcons = [
    deviceIcon1,
    deviceIcon2,
    deviceIcon3,
    deviceIcon4,
    deviceIcon5,
    deviceIcon6,
  ];
  static const deviceIconsTrailing = [
    Icon(Icons.shield, color: MyColors.lightBlue),
    Icon(Icons.shield, color: MyColors.lightBlue),
    Icon(Icons.shield, color: MyColors.lightBlue),
    Icon(Icons.shield_outlined, color: MyColors.lightBlue),
    Icon(Icons.shield_outlined, color: MyColors.lightBlue),
    Icon(Icons.warning_amber, color: Colors.red),
  ];

  static const deviceImages = [
    deviceImage1,
    deviceImage2,
    deviceImage3,
  ];

  static const deviceLastOnlines = [
    "Last online: 3 minutes ago",
    "Last online: 3 hours ago",
    "Last online: 1 day ago"
  ];
}
