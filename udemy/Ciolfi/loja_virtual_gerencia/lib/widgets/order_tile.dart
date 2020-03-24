import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/orders_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order ;

  OrderTile(this.order );

  final states = [
    "", "Em preparação", "Em transporte", "Aguardando Entrega", "Entregue"
  ];

  @override
  Widget build(BuildContext context) {
    final OrdersBloc bloc = BlocProvider.getBloc<OrdersBloc>();
    return Container(
      
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(order.documentID),
          initiallyExpanded: order.data["status"] != 4,
          title: Text("#${order.documentID.substring(order.documentID.length - 7 ,order.documentID.length )} - ${states[order.data["status"]]}",
              style: TextStyle(color: order.data["status"]!= 4 ? Colors.grey[850]: Colors.green)),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ 
                  OrderHeader(order),
                  Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: order.data["products"].map<Widget>((item){
                      return ListTile(
                        title: Text("${item["produto"]["title"]} ${item["tamanho"]}"),
                        subtitle: Text("${item["category"]} / ${item["idProduto"]} "),
                        trailing: Text(
                          item["qtde"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList()
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          bloc.remover(order);
                        },
                        textColor: Colors.red,
                        child: Text("Excluir"),
                      ),
                      FlatButton(
                        onPressed:order.data["status"] > 1? () {
                          bloc.regredir(order);
                        }:null,
                        textColor: Colors.grey[850],
                        child: Text("Regredir"),
                      ),
                      FlatButton(
                        onPressed: order.data["status"]<4? () {
                          bloc.avancar(order);
                        }:null,
                        textColor: Colors.green,
                        child: Text("Avançar"),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
