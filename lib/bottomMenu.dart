import 'package:fahsion/men_widget.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    controller.addStatusListener((status){
      if(status==AnimationStatus.completed){
        showBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context)=>MenWidget());
      }
    });

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double childWidth = (size.width - 16) / 3;
    return SafeArea(
      child: InkWell(
        onTap: () {
          controller.isCompleted ? controller.reverse() : controller.forward();
        },
        child: Container(
          width: size.width,
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: <Widget>[
              buildAnimatedBackGround(childWidth),
              AnimatedBuilder(
                animation: animation,
                builder: (context, snapshot) {
                  return buildBottomText('Women', childWidth, 0,animation.value>.5? Colors.black:Colors.white);
                }
              ),
              AnimatedBuilder(
                animation: animation,
                builder: (context, snapshot) {
                  return buildBottomText('Men', childWidth, childWidth, animation.value<.5? Colors.black:Colors.white);
                }
              ),
              buildBottomText('Kids', childWidth, childWidth * 2, Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomText(String text, double width, double left, Color color) {
    return Positioned(
      left: left,
      child: Container(
        height: 30,
        width: width,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedBackGround(double childWidth) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, snapshot) {
        return Positioned(
          height: 30,
          left: animation.value>.5?childWidth*2*(animation.value-.5):0,
          child: Container(
            width: animation.value<.5 ?childWidth*2*(animation.value+.5)
            :childWidth*2*(animation.value+.5+((.5-animation.value)*2)),
            decoration: BoxDecoration(
                color: mOrage, borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        );
      }
    );
  }
}
