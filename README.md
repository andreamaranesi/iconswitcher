# IconSwitcher

A Flutter plugin that allows you to create an icon switcher on the AppBar Widget

![](https://dremardesign.com/media/iconswitcher.gif)


### PARAMETERS

| NAME                    | DESCRIPTION                                                  | DEFAULT VALUE       |
| ----------------------- | ------------------------------------------------------------ | ------------------- |
| width                   | the final Widget width                                       | required            |
| height                  | the final Widget height                                      | required            |
| marginTop               | the final Widget marginTop                                   | required            |
| icon1                   | the first Icon                                               | required            |
| icon2                   | the second Icon                                              | required            |
| color1                  | the color of the first Icon                                  | required            |
| color2                  | the color of the second Icon                                 | required            |
| firstIconSelectedColor  | the color of the first selector                              | Colors.redAccent    |
| secondIconSelectedColor | the color of the second selector                             | Colors.orangeAccent |
| duration                | the animation duration when a user clicks on one of the icons | required            |
| curve                   | the animation Curve type                                     | Curves.bounceOut    |
| onChange                | Function(bool): return true when the first Icon is selected; false otherwise |                     |



EXAMPLE OF USAGE

You can use it to create multiple screen views inside a same Widget using all the Flutter Animated Widgets

CODE:

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconswitcher/iconswitcher.dart';

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
            firstIconSelectedColor: Colors.redAccent,
            secondIconSelectedColor: Colors.orangeAccent,
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
