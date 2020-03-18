import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/user_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/user_tile.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = BlocProvider.getBloc<UserBloc>();
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: bloc.onChangedSearch,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                hintText: "Pesquisar",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none),
          ),
        ),
        Expanded(
          child: StreamBuilder<List>(
              stream: bloc.outUsers,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                    ),
                  );
                else if (snapshot.data.length == 0)
                  return Center(
                      child: Text(
                    "Nenhum Usuário encontrado",
                    style: TextStyle(color: Colors.pinkAccent),
                  ));
                else
                  return ListView.separated(
                      itemBuilder: (_, index) {
                        return UserTile(snapshot.data[index]);
                      },
                      separatorBuilder: (_, index) {
                        return Divider();
                      },
                      itemCount: snapshot.data.length);
              }),
        )
      ],
    );
  }
}
