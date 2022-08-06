import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/providers/devices.dart';
import 'package:mpd_telekom/screens/main/device_management.dart';
import 'package:mpd_telekom/screens/main/prioritization_list.dart';
import 'package:provider/provider.dart';

import 'cockpit.dart';
import 'coming_soon.dart';

// See here for documentation:
// https://medium.flutterdevs.com/local-push-notification-in-flutter-763605b84985
// https://pub.dev/packages/flutter_local_notifications/example
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List _screens = const [
    Cockpit(),
    PrioritizationList(),
    DeviceManagement(),
    ComingSoon(),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  Future<void> scheduleNotification() async {
    // This determines the interval until the notification is shown
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 5));

    const BigTextStyleInformation bigTextStyleInformation =
        BigTextStyleInformation(
      'We detected a problem with your connection! The device "Herbert´s notebook" has an unstable connection.',
      //htmlFormatBigText: true,
      //htmlFormatContentTitle: true,
      //summaryText: 'summary <i>text</i>',
      //htmlFormatSummaryText: true,
    );
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Connection Problems',
      'Connection Problems',
      channelDescription: 'big text channel description',
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      priority: Priority.max,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        '1 Issue',
        'We detected a problem with your connection!',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  showNotification() async {
    var android = const AndroidNotificationDetails('id', 'channel ',
        channelDescription: 'description',
        priority: Priority.high,
        importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = const IOSInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String? payload) async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    }); // Potentially handle screen changes on notification here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("remoto.io"),
        backgroundColor: MyColors.lightBlue,
        elevation: 0,
        actions: [
          Consumer<DeviceModel>(
            builder: (context, deviceModel, child) => IconButton(
                onPressed: () {
                  deviceModel.createIssue();
                  scheduleNotification();
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: MyColors.lightBlue,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: "Prioritize",
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            label: "Devices",
            icon: Icon(Icons.devices),
            activeIcon: Icon(Icons.devices),
          ),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
