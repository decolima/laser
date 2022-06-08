import 'package:flutter/material.dart';

class CardBkm extends StatefulWidget {
  const CardBkm({Key? key}) : super(key: key);

  @override
  State<CardBkm> createState() => _CardBkmState();
}

class _CardBkmState extends State<CardBkm> {
  bool isChecked = false;
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
            children: [_descriptionField(), _linkField(), _checkCondiviso()],
          ),
        ),
      ),
    );
  }

  Widget _descriptionField() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci la descrizione',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  Widget _linkField() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci il link',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  Widget _checkCondiviso() => Row(
    children: [
      SizedBox(width: 28.0),
      const Text('Condiviso',
                  style: TextStyle(
                                  fontSize: 18.0,
                ),),
      Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
    ],
  );
}
