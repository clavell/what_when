import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BouncingButton extends StatefulWidget {
  final onPressed;
  final Icon icon;

  BouncingButton({this.onPressed, this.icon});

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  void _tapDown(TapDownDetails details) async {
    await _controller.forward();
    HapticFeedback.lightImpact();
  }

  void _tapUp(TapUpDetails details) async {
    HapticFeedback.mediumImpact();
    await _controller.reverse();
    widget.onPressed();
  }

  void _tapCancel() {
    _controller.reverse();
  }

  double _scale = 1.0;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..addListener(() {
        print(_controller.value);
        setState(() {
          _scale = 1 - _controller.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.8).animate(
            CurvedAnimation(parent: _controller, curve: Curves.elasticInOut)),
        child: widget.icon,
      ),
    );
  }
}
