import 'package:flutter/material.dart';

class GrowHideTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final sizeTween = Tween<double>(begin: 0, end: 300);
  final opacityTween = Tween<double>(begin: 0.1, end: 1);

  GrowHideTransition({this.child, this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, item) {
          
          return Opacity(
            opacity: opacityTween.evaluate(animation).clamp(0.1, 1),
            child: Container(
              height: sizeTween.evaluate(animation),
              width: sizeTween.evaluate(animation),
              child: item,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
