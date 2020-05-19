import 'package:flutter/material.dart';

class ItemMenuTile extends StatelessWidget {
  const ItemMenuTile({this.label, this.iconData, this.onTap, this.highlighted});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    var color = highlighted ? Colors.blue : Colors.black;
    return ListTile(
      title: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600, letterSpacing: 0.8, color: color)),
      leading: Icon(iconData, color: color),
      onTap: onTap,
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
    );
  }
}
