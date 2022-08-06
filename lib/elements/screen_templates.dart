import 'package:flutter/material.dart';

import '../constants/colors.dart';

class Infobox extends StatelessWidget {
  final String text;
  final Color color;
  final Widget icon;

  const Infobox(this.text,
      {Key? key,
      this.color = MyColors.white,
      this.icon = const Text("💡", style: TextStyle(fontSize: 30))})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 2,
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: MyColors.grey),
                ),
              )
            ],
          ),
        ));
  }
}

class ExceptionBox extends StatelessWidget {
  final String text;
  final Color color;

  const ExceptionBox(this.text, {Key? key, this.color = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 2,
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: MyColors.white, size: 30),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: MyColors.white),
                ),
              )
            ],
          ),
        ));
  }
}

class SmallBlueButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;

  final Function() function;
  static void noop() => {};

  const SmallBlueButton(
    this.text, {
    this.color = MyColors.lightBlue,
    this.height = 70,
    this.width = 80,
    this.borderRadius = 20,
    this.function = noop,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        child: Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          height: height,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            onTap: function,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: width,
                      child: Text(text,
                          style: const TextStyle(color: MyColors.white))),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: MyColors.white,
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class HighlightedContainer extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double borderRadius;

  const HighlightedContainer(
    this.text, {
    this.color = MyColors.white,
    this.height = 100,
    this.borderRadius = 30,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: height,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 3.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            color: color,
          ),
          child: Center(
              child: Text(text,
                  style: const TextStyle(fontStyle: FontStyle.italic)))),
    );
  }
}

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [const Background(), child],
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(flex: 1, child: Container(color: MyColors.lightBlue)),
        Expanded(flex: 3, child: Container(color: MyColors.white))
      ],
    );
  }
}
