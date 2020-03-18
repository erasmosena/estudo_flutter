import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/user_bloc.dart';
import 'package:loja_virtual_gerencia/tabs/orders_tab.dart';
import 'package:loja_virtual_gerencia/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;
  

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.pinkAccent,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white54))),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: Duration(milliseconds: 200),
                curve: Curves.linearToEaseOut);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Clientes")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Pedidos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text("Produtos"))
          ],
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          blocs: [
            Bloc((i) => UserBloc()),
          ],
          child: PageView(
            onPageChanged: (p) {
              setState(() {
                _page = p;
              });
            },
            controller: _pageController,
            children: <Widget>[UsersTab(), OrdersTab(), Container()],
          ),
        ),
      ),
    );
  }
}
