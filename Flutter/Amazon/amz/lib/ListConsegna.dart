import 'package:amz/DettagliConsegna.dart';
import 'package:amz/control/AppControl.dart';
import 'package:amz/entity/User.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class DoListConsegna extends StatefulWidget {
  @override
  State<DoListConsegna> createState() => _DoListConsegna();
}

class _DoListConsegna extends State<DoListConsegna> {
  // var cnsg = <Consegna>[];
/*
  _getConsegna() {
    AppControl.clearConsegna();
    ConsegnaStore.getConsegna(AppControl.getUser()!, 1, 1000);
    cnsg = AppControl.getConsegna();

    for (var a in cnsg) {
      print(a.peso);
    }
  }

  _DoListConsegna() {
    _getConsegna();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista di Consegne"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  User u = User();
                  AppControl.setUser(u);
                  AppControl.clearConsegna();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WidgetLogin()));
                })
          ],
        ),
        body: getUtenti());
  }

  int _selectedIndex = -1;

  getUtenti() {
    return ListView.builder(
        itemCount: AppControl.getConsegna().length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.blue,
            selected: index == _selectedIndex,
            title: Text(AppControl.getConsegna()[index].indirizzo.toString()),
            subtitle: Text(
                "${AppControl.getConsegna()[index].idamazon} - ${AppControl.getConsegna()[index].dimensione} - ${AppControl.getConsegna()[index].pesopaco}"),
            onTap: () {
              setState(() {
                _selectedIndex = index;
                AppControl.setIndex(index);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DettagliConsegna()));
              });
            },
          );
        });
  }
}
