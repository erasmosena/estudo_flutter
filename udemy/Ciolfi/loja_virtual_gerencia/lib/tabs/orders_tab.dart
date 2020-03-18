import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 16),
    child: ListView.builder(
      itemCount: 6,
      itemBuilder: (_, index){
        return OrderTile();
      }),
    );
  }
}
