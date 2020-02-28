import 'package:flutter/material.dart';
import 'package:logo_app/widget/animation/grow_hide_transition.dart';
import 'package:logo_app/widget/logo.dart';

import 'widget/animation/grow_transition.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController _controllerAnimation;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controllerAnimation =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent:_controllerAnimation,curve: Curves.elasticOut);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerAnimation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controllerAnimation.forward();
      }
    });
    _controllerAnimation.forward();
  }

  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GrowHideTransition(animation: _animation,child: LogoWidget(),);
  }
}



