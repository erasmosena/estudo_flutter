import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  Widget _buildBar(int n, String pass) {
    final int level = _calcScorePass(pass);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: n <= level ? _getColor(level) : Colors.transparent,
            border: n > level ? Border.all(color:Colors.grey):null)
            
      ),
    );
  }

  int _calcScorePass(String pass) {
    int score = 0;
    if (pass.length > 8) score++;
    if (pass.contains(RegExp(r'[0-9]'))) score++;
    if (pass.contains(RegExp(r'[A-Z]'))) score++;
    if (pass.contains(RegExp(r'[^A-Za-z0-9_]'))) score++;
    return score;
  }

  Color _getColor(int score) {
    switch (score) {
      case 0:
        return Colors.red;
        break;
      case 1:
        return Colors.orange;
        break;
      case 2:
        return Colors.yellow;
        break;
      case 3:
        return Colors.greenAccent;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: '',
      builder: (state) {
        return Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: state.didChange,
            ),
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 8,
              child: Row(
                children: <Widget>[
                  _buildBar(0, state.value),
                  _buildBar(1, state.value),
                  _buildBar(2, state.value),
                  _buildBar(3, state.value),
                  _buildBar(4, state.value),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
