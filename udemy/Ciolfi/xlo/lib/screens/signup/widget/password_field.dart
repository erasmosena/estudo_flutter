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
              border: n > level ? Border.all(color: Colors.grey) : null)),
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

  String _getText(int score) {
    switch (score) {
      case 0:
        return 'Senha muito fraca';
        break;
      case 1:
        return 'Senha fraca';
        break;
      case 2:
        return 'Senha regular';
        break;
      case 3:
        return 'Senha forte';
        break;
      case 4:
        return 'Senha muito forte!';
        break;
      default:
        return 'Senha muito fraca';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (text) {
        if (text.isEmpty || _calcScorePass(text) < 3) {
          return 'Senha inválida';
        }
        return null;
      },
      initialValue: '',
      builder: (state) {
        int score = _calcScorePass(state.value);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: state.didChange,
            ),
            state.value.isNotEmpty
                ? Container(
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
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10),
              child: state.value.isNotEmpty || state.hasError
                  ? Text(state.hasError ? state.errorText : _getText(score),
                      textAlign: TextAlign.start,
                      style: TextStyle(color: _getColor(score)))
                  : Container(),
            )
          ],
        );
      },
    );
  }
}
