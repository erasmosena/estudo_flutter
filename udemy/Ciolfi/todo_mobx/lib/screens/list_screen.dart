import 'package:flutter/material.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:todo_mobx/store/list_store.dart';
import 'package:todo_mobx/widget/custo_text_field.dart';
import 'package:todo_mobx/widget/custom_icon_button.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  ListStore listStore = ListStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32)),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        hint: 'Tarefa',
                        onChanged: listStore.setNewTodoTitle,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: Icons.add,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text('Item $index'),
                                onTap: () {},
                              );
                            },
                            separatorBuilder: (_, __) {
                              return Divider();
                            },
                            itemCount: 10),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
