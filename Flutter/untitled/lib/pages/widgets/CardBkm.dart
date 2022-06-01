import 'package:flutter/material.dart';

class CardBkm extends StatefulWidget {
  const CardBkm({Key? key}) : super(key: key);

  @override
  State<CardBkm> createState() => _CardBkmState();
}

class _CardBkmState extends State<CardBkm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          width: 500.0,
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }

}
