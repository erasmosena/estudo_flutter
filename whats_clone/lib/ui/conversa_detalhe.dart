import 'package:flutter/material.dart';

class ConversaDetalhe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(children: [
              ListTile(
                leading: new Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),
                title: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text('Mensagem', textAlign: TextAlign.start)),
                    Flexible(
                        child: Text(
                      "21/12/2019",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.normal),
                    )),
                  ],
                ),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
