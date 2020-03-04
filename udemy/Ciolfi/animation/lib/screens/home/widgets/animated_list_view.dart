import 'package:animation/screens/home/widgets/list_data.dart';
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class AnimatedListView extends StatelessWidget {

  final Animation<EdgeInsets>  listSlidePosition;

  AnimatedListView({@required this.listSlidePosition});

  @override
  Widget build(BuildContext context) {
    int i = 0 ;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListData(
          title: lipsum.createWord( numWords: 3),
          subtitle: lipsum.createWord( numWords: 3),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 7 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 3),
          subtitle: lipsum.createWord( numWords: 3),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 6 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 3),
          subtitle: lipsum.createWord( numWords: 3),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 5 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 3),
          subtitle: lipsum.createWord( numWords: 3),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 4 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 3),
          subtitle: lipsum.createWord( numWords: 3),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 3 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 4),
          subtitle: lipsum.createWord( numWords: 4),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 2 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 4),
          subtitle: lipsum.createWord( numWords: 4),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 1 ,
        ),
        ListData(
          title: lipsum.createWord( numWords: 4),
          subtitle: lipsum.createWord( numWords: 4),
          image: AssetImage('images/perfil.jpeg'),
          margin: listSlidePosition.value * 0 ,
        )
      ],
    );
  }
}