import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/styles.dart';
import '../main/cockpit.dart';
import 'solution_step_1.dart';

class ProblemOverview extends StatelessWidget {
  const ProblemOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Solving your problem'),
          backgroundColor: MyColors.lightBlue,
        ),
        backgroundColor: MyColors.white,
        bottomNavigationBar: const BottomNavigationButton(),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Column(
              children: const [
                H1("Unstable connection on your device"),
                ProblemBox(),
                SizedBox(height: 10),
                H2("This is how you can fix it:"),
                SolutionBox(children: [
                  SolutionBoxEntry(
                      index: 1,
                      title: "Change your position",
                      description:
                          "Distance from router and thick walls can affect your internet stability."),
                  Divider(thickness: 1),
                  SolutionBoxEntry(
                      index: 2,
                      title: "Get rid of bottlenecks",
                      description:
                          "Old devices slow down your network. This can affect the internet experience on Herbert’s notebook."),
                  Divider(thickness: 1),
                  SolutionBoxEntry(
                      index: 3,
                      title: "Prioritize this device",
                      description:
                          "We found devices in your network performing large downloads. This can affect the internet experience on Herbert’s notebook.")
                ]),
                SizedBox(height: 20),
              ],
            ),
          )),
        ));
  }
}

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: const BoxDecoration(
        color: Colors.white,
        //border: Border(top: BorderSide(width: 0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            offset: Offset(-3.0, 0),
            color: MyColors.grey,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: CupertinoButton(
              color: MyColors.lightBlue,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Step1_Loc()),
                    /*CheckingConnection(
                              destinationClassBuilder: (context) =>
                                  const ProblemOverview(),
                            )),*/
                  ),
              child: const Text("Fix it now",
                  style: TextStyle(
                    color: MyColors.white,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
      ),
    );
  }
}

class ProblemBox extends StatefulWidget {
  const ProblemBox({Key? key}) : super(key: key);

  @override
  State<ProblemBox> createState() => _ProblemBoxState();
}

class _ProblemBoxState extends State<ProblemBox>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 4).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: SizedBox(
                width: 330,
                child: Column(children: [
                  DeviceEntry(
                      deviceIndex: 0, animation: animation, animationOffset: 1),
                  const Divider(thickness: 1),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text("❌", style: TextStyle(fontSize: 20)),
                      ),
                      title: const Text("Not ready for video calls"),
                      textColor: Colors.black,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 280,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'The '),
                                      TextSpan(
                                          text: 'connection quality',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              ' repeatedly dropped in the last 30 minutes.'),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.wifi_tethering_error, size: 50),
                              ),
                              const Flexible(
                                flex: 1,
                                child: Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'This means you can '),
                                      TextSpan(
                                          text: 'browse the internet',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              ' without problems, but might have a bad experience with applications like '),
                                      TextSpan(
                                          text: 'video calls.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}

class SolutionBox extends StatelessWidget {
  final List<Widget> children;

  const SolutionBox({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: SizedBox(width: 330, child: Column(children: children))));
  }
}

class SolutionBoxEntry extends StatelessWidget {
  final int index;
  final String title;
  final String description;

  const SolutionBoxEntry({
    Key? key,
    required this.index,
    required this.title,
    required this.description,
  }) : super(key: key);

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey expansionTileKey = GlobalKey();
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            leading: Container(
              width: 32,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.lightBlue),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("$index",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            title: Text(title, style: const TextStyle(fontSize: 16)),
            textColor: Colors.black,
            key: expansionTileKey,
            onExpansionChanged: (value) {
              if (value) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey);
              }
            },
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 70, top: 15, bottom: 15, right: 25),
                child: Text(description, style: const TextStyle(fontSize: 16)),
              )
            ]));
  }
}

class ArrowButton extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double borderRadius;

  final Function() function;
  static void noop() => {};

  const ArrowButton({
    this.color = MyColors.lightBlue,
    this.height = 70,
    this.width = 40,
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
          width: width,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            onTap: function,
            child: const Center(
                child: Icon(
              Icons.arrow_forward_ios,
              color: MyColors.white,
            )),
          ),
        ),
      ),
    );
  }
}

class H2 extends StatelessWidget {
  const H2(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 20),
        child: Text(text,
            textAlign: TextAlign.start,
            style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: MyColors.darkBlue)),
      ),
    );
  }
}
