import 'package:flutter/material.dart';

import 'conversa_detalhe.dart';

class ConversasList extends StatefulWidget {
  @override
  _ConversasListState createState() => _ConversasListState();
}

class _ConversasListState extends State<ConversasList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<ConversaDetalhe>_conversas =[
    ConversaDetalhe(),
    ConversaDetalhe(),
    ConversaDetalhe(),
    ConversaDetalhe(),
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _conversas);
  }
}