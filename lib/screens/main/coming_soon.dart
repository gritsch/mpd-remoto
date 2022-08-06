import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_telekom/constants/colors.dart';

const String titleText = "Coming soon!";
const String subtitleText =
    "We are currently working on this feature!\n\nVisit our website to get more info about our roadmap, or tell us your opinion at feedback@remoto.io";

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Remoto")),
        body: Column(children: const [
          Expanded(
            flex: 4,
            child: BigHeaderImage(),
          ),
          Expanded(
            flex: 3,
            child: ComingSoonText(),
          )
        ]));
  }
}

class ComingSoonText extends StatelessWidget {
  const ComingSoonText({
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
              children: const [
                Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitleText,
                  style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                BlackAndRedDividerSymbol(),
                SizedBox(height: 20),
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
        ShortDivider(color: Colors.black, width: 40),
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
                    image: AssetImage("assets/wohnzimmer.jpg"))
                //    child: FittedBox(
                //    fit: BoxFit.fitHeight, child: Image.asset("assets/wohnzimmer.jpg")),
                )));
  }
}
