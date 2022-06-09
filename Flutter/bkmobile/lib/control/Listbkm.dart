import 'package:backendrest/control/BkmsStore.dart';
import 'package:backendrest/control/appControl.dart';
import 'package:flutter/material.dart';

class Listbkm extends StatefulWidget {
  @override
  State<Listbkm> createState() => _Listbkm();
}

class _Listbkm extends State<Listbkm> {
  Widget build(BuildContext context) {
    return Scaffold(body: getBkm());
  }

  int _selectedIndex = -1;

  _getBkm() {
    bkmsStore.getBkms(appControl.getUser());
  }

  _Listbkm() {
    _getBkm();
  }

  getBkm() {
    return ListView.builder(
        itemCount: appControl.getBkms().length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.blue,
            selected: index == _selectedIndex,
            title: Text(appControl.getBkms()[index].descrizione.toString()),
            subtitle: Text(appControl.getBkms()[index].link.toString()),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
