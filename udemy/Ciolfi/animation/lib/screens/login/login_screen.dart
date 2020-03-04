import 'package:animation/screens/home/home_screen.dart';
import 'package:animation/screens/login/widgets/form_container.dart';
import 'package:animation/screens/login/widgets/sign_up_button.dart';
import 'package:animation/screens/login/widgets/stagger_animation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  AnimationController _animationController ;

  @override
  void initState() { 
    super.initState();
    _animationController =  AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    );

    _animationController.addStatusListener((status){
      if(status == AnimationStatus.completed)
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomeScreen()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/background.jpg"),fit: BoxFit.cover)),
            child: ListView(
              padding:  EdgeInsets.zero,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top:70, bottom: 32),
                          child: Image.asset("images/tickicon.png",width: 150, height: 150,fit: BoxFit.contain,),
                        ),
                        FormContainer(),
                        SingUpButton()
                      ],
                    ),
                    StaggerAnimation(
                      controller: _animationController.view
                    )
                  ],
                )
              ],
            ),
      ),
    );
  }
}
