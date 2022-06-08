import 'package:flutter/material.dart';
import 'package:untitled/pages/widgets/CardBkm.dart';

class ListBkm extends StatefulWidget {
  @override
  State<ListBkm> createState() => _ListBkmState();
}

class _ListBkmState extends State<ListBkm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: creaLista(),
    );
  }

  creaLista() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            focusColor: Colors.white30,
            title: Text('Descrizione'),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('link'), Text('condiviso')]),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => new CardBkm(),
                ),
              );
            },
          );
        });
  }
}
