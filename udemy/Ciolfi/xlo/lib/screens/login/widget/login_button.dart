import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      height: 50,
      child: StreamBuilder(
        builder: (context, snapshot) {
          return RaisedButton(
            color: Colors.pink,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: (){},
            disabledColor: Colors.pink.withAlpha(150),
            child: Text('Entrar',style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),),
          );
        },
      ),
    );
  }
}
