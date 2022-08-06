import 'package:flutter/material.dart';
import 'package:mpd_telekom/providers/devices.dart';
import 'package:mpd_telekom/screens/onboarding/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeviceModel(),
      child: MaterialApp(
        title: 'Home Office Home Network App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      ),
    );
  }
}
