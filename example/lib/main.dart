import 'package:flutter/material.dart';
import 'package:iconswitcher/iconswitcher.dart';

void main() {
  runApp(Screen());
}

class Screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Screen();
  }
}

class _Screen extends State<Screen> with TickerProviderStateMixin {
  bool left = true;
  Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    double marginTop = 1.5;
    double height = kToolbarHeight - marginTop * 2;
    double width = height * 2;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Title",
            ),
            actions: <Widget>[
              IconSwitcher(
                width,
                height,
                marginTop,
                duration,
                Icons.satellite,
                Icons.content_copy,
                Colors.purple,
                Colors.white,
                Colors.black,
                firstIconSelectedColor: Colors.redAccent,
                secondIconSelectedColor: Colors.orangeAccent,
                onChange: (bool result) {
                  setState(() {
                    left = result;
                  });
                },
              )
            ],
          ),
          body: AnimatedCrossFade(
            firstChild: Container(
              color: Colors.black54,
            ),
            secondChild: Container(
              color: Colors.orange,
            ),
            duration: duration,
            crossFadeState:
                left ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            firstCurve: Curves.bounceOut,
            secondCurve: Curves.bounceOut,
          ),
        ));
  }
}
