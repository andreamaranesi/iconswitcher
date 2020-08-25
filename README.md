# IconSwitcher

A Flutter plugin that allows you to create an icon switcher on the AppBar Widget

EXAMPLE OF USAGE

You can use it to create multiple screen views inside a same Widget using all the Flutter Animated Widgets

CODE:

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'iconswitcher.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "prova",
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
    );
  }
}


```
