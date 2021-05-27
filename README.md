# IconSwitcher

A Flutter plugin that allows you to create an icon switcher on the AppBar Widget

![](https://github.com/andreamaranesi/iconswitcher/blob/master/iconswitcher.gif?raw=true)



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
| duration                | the animation duration when a user clicks on one of the icons | required            |
| firstIconSelectedColor  | the color of the first selector                              | Colors.redAccent    |
| secondIconSelectedColor | the color of the second selector                             | Colors.orangeAccent |
| curve                   | the animation Curve type                                     | Curves.bounceOut    |
| onChange                | Function(bool): return true when the first Icon is selected; false otherwise |                     |


EXAMPLE OF USAGE

You can use it to create multiple screen views inside a same Widget using all the Flutter Animated Widgets

CODE:

```dart

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

```
