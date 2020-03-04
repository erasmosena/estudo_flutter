import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final EdgeInsets margin;

  ListData({@required this.title, @required this.subtitle, @required this.image, @required this.margin});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          top: BorderSide(color: Colors.grey,width: 1),
          bottom: BorderSide(color: Colors.grey,width: 1)
        )
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: image)
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text(title,
               maxLines: 2,
               style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.w400
               ),),
               SizedBox(height: 5,),
               Text(subtitle,
               maxLines: 2,
               style: TextStyle(
                 fontSize: 14,
                 color: Colors.grey,
                 fontWeight: FontWeight.w300
               ),)
             ],
          )
        ],
      ),
    );
  }
}
