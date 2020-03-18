import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> _user;

  UserTile(this._user);

  @override
  Widget build(BuildContext context) {
    if ( _user.containsKey("money")) {
      var style = TextStyle(color: Colors.white);
      return ListTile(
        title: Text(
          _user["name"],
          style: style,
        ),
        subtitle: Text(
          _user["email"],
          style: style,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Pedidos ${_user["orders"]} ", style: style),
            Text("Gastos  R\$${_user["money"].toStringAsFixed(2)} ",
                style: style)
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            SizedBox(
                width: 200,
                height: 20,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.white.withAlpha(50),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey))
          ],
        ),
      );
    }
  }
}
