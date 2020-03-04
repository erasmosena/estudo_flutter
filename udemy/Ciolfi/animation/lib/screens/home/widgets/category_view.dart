import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  final List<String> categories = [
    "Trabalho",
    "Estudo",
    "Casa",
  ];
  int _category = 0 ;

  void selectFoward(){
    setState(() {
      _category++;  
    });
    
  }
  void selectBackward(){
    setState(() {
      
      _category--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          iconSize: 30,
          color: Colors.white,
          disabledColor: Colors.white30,
          onPressed:_category > 0?selectBackward:null,
        ),
        Expanded(
          child: Text(
            categories[_category].toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
                letterSpacing: 1.2,
                color: Colors.white),
          ),
        ),
        IconButton(
          enableFeedback: true,
          icon: Icon(
            Icons.chevron_right,
          ),
          iconSize: 30,
          color: Colors.white,
          onPressed: _category < categories.length - 1 ?selectFoward:null,
          disabledColor: Colors.white30,
        ),
      ],
    );
  }
}
