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
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.animationCompleted.call(0);
        }
        if (status == AnimationStatus.dismissed) {
          widget.animationCompleted.call(1);
        }
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FlipAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
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
          ..setEntry(3, 2, 0.001)
          ..rotateY(_animation.value * pi),
        child: _animation.value < 0.5
          ? Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Icon(Icons.question_mark, size: 50, color: Colors.white),
            )
          : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(pi),
              child: widget.word,
            ),
      ),
    );
  }
}