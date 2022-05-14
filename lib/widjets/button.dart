import 'package:flutter/material.dart';
import '../style.dart';

class button_widjet extends StatelessWidget {
  String linc;
  String text;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: s.buttonColor, minimumSize: Size(width, height)),
      onPressed: () {
        Navigator.pushNamed(context, linc);
      },
      child: Text("${text}", style: TextStyle(color: Colors.white)),
    );
  }

  button_widjet(
      {required this.text,
      required this.linc,
      required this.width,
      required this.height});
}
