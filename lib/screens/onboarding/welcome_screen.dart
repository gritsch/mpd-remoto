import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';
import 'package:mpd_telekom/screens/onboarding/onboarding_overview.dart';

import '../main/home.dart';

const String title = "Get ready to work\nfrom home.\nSafe and simple.";
const String subtitle =
    "Remoto is your way of being productive in a changing world: remote without limitations.";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: const [
      Expanded(
        flex: 4,
        child: BigHeaderImage(),
      ),
      Expanded(
        flex: 3,
        child: WelcomeText(),
      )
    ]));
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            color: Color.fromRGBO(230, 230, 230, 1.0),
            blurRadius: 50.0,
            spreadRadius: 50.0,
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false),
                  child: const Text(
                    title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Text(
                  subtitle,
                  style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const BlackAndRedDividerSymbol(),
                const BottomButton(),
              ])),
    );
  }
}

class BlackAndRedDividerSymbol extends StatelessWidget {
  const BlackAndRedDividerSymbol({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ShortDivider(color: MyColors.darkBlue, width: 40),
        ShortDivider(color: Colors.transparent, width: 5),
        ShortDivider(color: Colors.red, width: 10),
      ],
    );
  }
}

class ShortDivider extends StatelessWidget {
  final Color color;
  final double width;

  const ShortDivider({Key? key, this.color = Colors.black, this.width = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: width,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          color: color),
    );
  }
}

class BigHeaderImage extends StatelessWidget {
  const BigHeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    alignment: FractionalOffset.center,
                    image: AssetImage("assets/home_office.png")))));
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: MyColors.lightBlue,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OnboardingOverviewScreen2()),
            ),
        child: const Text("Get started",
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
            )));
  }
}
