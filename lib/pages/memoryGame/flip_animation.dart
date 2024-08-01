import 'dart:math';
import 'package:flutter/material.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({
    Key? key,
    required this.word,
    required this.animate,
    this.reverse = false,
    required this.animationCompleted,
  }) : super(key: key);

  final Widget word;
  final bool animate;
  final bool reverse;
  final Function(int) animationCompleted;

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 2600), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.animationCompleted.call(0);
            }
            if (status == AnimationStatus.dismissed) {
              print('animation completed reversed');
              widget.animationCompleted.call(1);
            }
          });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
  }

  @override
  void didUpdateWidget(covariant FlipAnimation oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        if (widget.reverse) {
          _controller.reverse();
        } else {
          _controller.reset();
          _controller.forward();
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateY(_animation.value * pi)
            ..setEntry(3, 2, 0.005),
          child: _controller.value >= 0.50
              ? widget.word
              : Container(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Icon(
                    Icons.question_mark,
                    size: 50,
                    color: Colors.white,
                  ),
                )),
    );
  }
}