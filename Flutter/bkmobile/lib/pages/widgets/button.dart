import 'package:flutter/material.dart';

class Bkmbutton extends StatelessWidget {
  const Bkmbutton({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Color color = Colors.teal;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () {
          onPressed();
        });
  }
}

