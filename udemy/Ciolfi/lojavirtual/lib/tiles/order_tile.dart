import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  OrderTile(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data['status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Código do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    _buildProductText(snapshot.data)
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "Status do pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação",status,1 ),
                      Container(
                        color: Colors.grey[500],
                        height: 1,
                        width: 40,
                      ),
                      _buildCircle("2", "Transporte",status,2 ),
                      Container(
                        color: Colors.grey[500],
                        height: 1,
                        width: 40,
                      ),
                      _buildCircle("3", "Entrega",status,3 )
                    ],
                  )
                  
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot){
    String text = "Descrição: \n";
    String total = snapshot["totalPrice"].toStringAsFixed(2);
    snapshot.data["products"].forEach( 
      ( it) {
        String desc = it["produto"]["title"];
        String qtd = it["qtde"].toString();
        String price = it["produto"]["price"].toStringAsFixed(2);
        
        text += "${qtd} x ${desc} ( R\$ ${price})\n";
      }
    );
    text += "Total ${total}\n";
    return text;
  }

  Widget _buildCircle(String title, String subTitle, int status, int thisStatus){
    Color backColor;
    Widget child;
    if( status < thisStatus){
      backColor = Colors.grey;
      child = Text(title, style: TextStyle(color:Colors.white),);
    }else if( status == thisStatus){
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color:Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Colors.white,

              ),
          )
        ],
      );
    
    }else {
      backColor = Colors.green;
      child = Icon(Icons.check);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subTitle)
      ],
    );
  }
}
