import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.data,this.mine);
  
  final Map<String,dynamic> data ;
  final bool mine;


  @override
  Widget build(BuildContext context) {
    Widget msg = data["imgUrl"] != null ?
      Image.network(data["imgUrl"],width: 250,): 
      Text(
        data["text"],
        style: TextStyle(
          fontSize: 20
        ),
      );
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: 
          mine?
         _getMyRowMsg(msg):
         _getOthersRowMsg(msg)
    );
  }

  Widget _getMyRowMsg(Widget msg){
    return Row(
      children: <Widget>[
        
        Expanded(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                data["senderName"],
                textAlign: TextAlign.right,
                style: TextStyle(                  
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                ),
              ),msg,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(data["senderPhotoUrl"]),
          ),
        ),
      ],
    );
  }

  Widget _getOthersRowMsg(Widget msg){
    
    return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(data["senderPhotoUrl"]),
            ),
          ),
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                Text(
                  data["senderName"],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
                msg,
              ],
            ),
          ),
        ],
      );
  }
}