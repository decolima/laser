import 'package:flutter/material.dart';
import '../entity/bkms.dart';
import '../service/rest.dart';

class BkmsStore extends StatefulWidget {
  @override
  State<BkmsStore> createState() => _BkmsStore();
}

class _BkmsStore extends State<BkmsStore> {
  final _bkms = <Bkms>[];

  _getBkms() {
    try {
      rest.getRest("/bkms", false, "").then((response) {
        setState(() {
          for (var e in response) {
            _bkms.add(Bkms.fromJson(e));
          }
        });
      });
    } catch (e) {
      print("Problema per caricare Bkms ...");
    }
  }

  _Bkms() {
    _getBkms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Bkms"),
      ),
      body: getBkms(),
    );
  }

  getBkms() {
    return ListView.builder(
        itemCount: _bkms.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(_bkms[index].descrizione.toString()),
              subtitle: Text(_bkms[index].idbkm.toString()));
        });
  }
}
