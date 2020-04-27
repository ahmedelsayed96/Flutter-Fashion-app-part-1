import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  Duration delay;
  Curve curve;
  Function(BuildContext context, Widget child, double value) builder;

  Animator(
      {@required this.builder,
      this.curve = Curves.linear,
      this.delay = const Duration()});

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Timer timer;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        upperBound: .99,
        lowerBound: .1);
    animation = CurvedAnimation(parent: controller, curve: widget.curve);
    timer = Timer(widget.delay, controller.forward);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return widget.builder(context, child, animation.value);
      },
    );
  }
}
