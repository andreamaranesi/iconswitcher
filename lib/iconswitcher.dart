import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class iconException implements Exception{
  final message;

  iconException(this.message);

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class IconSwitcher extends StatefulWidget{

  static const MethodChannel _channel =
  const MethodChannel('iconswitcher');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  double width,height,marginTop;
  final Duration duration;
  final Function(bool) onChange;
  final IconData icon1,icon2;
  final Color color1,color2,backgroundColor;
  final Curve curve;

  IconSwitcher({@required this.width,@required this.height,@required this.marginTop,@required this.duration, this.onChange,
    @required this.icon1, @required this.icon2, @required this.color1, @required this.color2,
    @required this.backgroundColor, this.curve=Curves.bounceOut});

  @override
  State<StatefulWidget> createState(){

    if(icon1==null || icon2==null || color1==null || color2==null || backgroundColor==null){
      throw new iconException("Error in IconSwitcher. You missed to fill all required parameters");
    }
    return _iconswitcher(duration: duration,curve: curve);
  }

}

class _iconswitcher extends State<IconSwitcher> with TickerProviderStateMixin{
  final Duration duration;
  final Curve curve;
  _iconswitcher({this.duration, this.curve});

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: duration, vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(new CurvedAnimation(
        parent: controller,
        curve: curve
    ))
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  bool left = true;

  @override
  Widget build(BuildContext context) {

    Animatable<Color> iconColor1 = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: widget.color2,
          end: widget.color1,
        ),
      ),
    ]);
    Animatable<Color> iconColor2 = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: widget.color1,
          end: widget.color2,
        ),
      ),
    ]);

    double width=widget.width;
    double height=widget.height;
    double marginTop=widget.marginTop;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: marginTop),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 5,
            width: width,
            height: height-10,
            child: Container(
              width: width,
              height: height-20,
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(width/2)
              ),
            ),
          ),
          Positioned(
            left: left ? width/2*(1-animation.value): animation.value*(width / 2),
            top: 0,
            height: height,
            width: width / 2,
            child: AnimatedContainer(
              curve: curve,
              duration: duration,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: left ? Colors.pinkAccent : Colors.orange,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            width: width / 2 - 20,
            height: height-20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: height-20, maxWidth: width / 2 - 20),
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.transparent,
                      icon: Icon(
                        widget.icon1,
                        color: left?iconColor2.evaluate(AlwaysStoppedAnimation(controller.value)):
                        iconColor1.evaluate(AlwaysStoppedAnimation(controller.value)),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          left = true;
                          widget.onChange(true);
                          controller.reset();
                          controller.forward();
                        });
                      },
                    ))
              ],
            ),
          ),
          Positioned(
            left: width / 2 + 10,
            height: height-20,
            top: 10,
            width: width / 2 - 20,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: height-20, maxWidth: width / 2 - 20),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.transparent,
                        icon: Icon(
                          widget.icon2,
                          color: !left?iconColor2.evaluate(AlwaysStoppedAnimation(controller.value)):
                          iconColor1.evaluate(AlwaysStoppedAnimation(controller.value)),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            left = false;
                            widget.onChange(false);
                            controller.reset();
                            controller.forward();
                          });
                        },
                      ))
                ]),
          ),
        ],
      ),
    );
  }


}