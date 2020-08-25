import 'package:flutter/material.dart';
import 'package:iconswitcher/iconswitcher.dart';

void main() {
  runApp(screen());
}


class screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _screen();
  }
}

class _screen extends State<screen> with TickerProviderStateMixin {
  bool left = true;
  Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    double marginTop = 1.5;
    double height = kToolbarHeight - marginTop * 2;
    double width = height * 2;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Title",
        ),
        actions: <Widget>[
          IconSwitcher(
            width: width,
            height: height,
            marginTop: marginTop,
            color1: Colors.purple,
            color2: Colors.white,
            icon1: Icons.satellite,
            icon2: Icons.content_copy,
            backgroundColor: Colors.black,
            duration: duration,
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