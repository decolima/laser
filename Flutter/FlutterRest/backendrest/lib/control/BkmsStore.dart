import 'dart:ffi';

import '../entity/bkms.dart';
import '../entity/user.dart';
import '../service/rest.dart';

class bkmsStore {
  static Future postBkms(
      User usr, String desc, String link, bool shared) async {
    dynamic data = {
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo',
      'motivorim': ""
    };
    late Bkms _bkms;
    try {
      var resp = await rest.postRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          idbkm: 0 as Long);
    }
  }

  static Future getBkms(User usr) async {
    late Bkms _bkms;
    try {
      var resp = await rest.getRest("/books", true, usr.token);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);

      /*
        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });
        */
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          idbkm: 0 as Long);
    }
  }

  static Future putBkms(
      User usr, Long id, String desc, String link, bool shared) async {
    dynamic data = {
      'id': id,
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo',
      'motivorim': ""
    };
    late Bkms _bkms;
    try {
      var resp = await rest.putRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          idbkm: 0 as Long);
    }
  }
}






/*
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
*/