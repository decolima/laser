import 'package:backendrest/control/BkmsStore.dart';
import 'package:backendrest/control/appControl.dart';
import 'package:flutter/material.dart';

class Listbkm extends StatefulWidget {
  @override
  State<Listbkm> createState() => _Listbkm();
}

class _Listbkm extends State<Listbkm> {
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: getBkm());
  }

  int _selectedIndex = -1;

  _getBkm() {
    BkmsStore.getBkms(AppControl.getUser());
  }

  _Listbkm() {
    _getBkm();
  }

  getBkm() {
    return ListView.builder(
        itemCount: AppControl.getBkms().length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.blue,
            selected: index == _selectedIndex,
            title: Text(AppControl.getBkms()[index].descrizione.toString()),
            subtitle: Text(AppControl.getBkms()[index].link.toString()),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
