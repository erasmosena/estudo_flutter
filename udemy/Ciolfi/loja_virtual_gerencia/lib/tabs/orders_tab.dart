import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/orders_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersBloc bloc = BlocProvider.getBloc<OrdersBloc>();
    return Padding(
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
    );
  }
}
