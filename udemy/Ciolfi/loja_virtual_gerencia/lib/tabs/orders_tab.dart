import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loja_virtual_gerencia/blocs/orders_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersBloc bloc = BlocProvider.getBloc<OrdersBloc>();
    return  Scaffold(
      floatingActionButton: SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
                child: Icon(Icons.arrow_downward, color: Colors.pinkAccent),
                backgroundColor: Colors.white,
                label: "Concluidos Abaixo",
                labelStyle: TextStyle(fontSize: 14),
                onTap: () {
                  bloc.sortCriteria(SortCriteria.READY_LAST);
                }),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward, color: Colors.pinkAccent),
                backgroundColor: Colors.white,
                label: "Concluidos Acima",
                labelStyle: TextStyle(fontSize: 14),
                onTap: () {
                  bloc.sortCriteria(SortCriteria.READY_FIRST);
                }),
          ],
        ),
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<List>(
            stream: bloc.outOrders,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              }else if( snapshot.data.length == 0 ) {   
                return Center(
                  child: Text("Nenhum pedido encontrado.",style:TextStyle(color: Colors.pinkAccent))
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return OrderTile(snapshot.data[index]);
                    });
              }
            }),
      ),
    );
  }
}
