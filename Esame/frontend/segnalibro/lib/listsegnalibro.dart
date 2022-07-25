import 'package:flutter/material.dart';
import '../../control/AppControl.dart';

class Listbkm extends StatefulWidget {
  const Listbkm({Key? key}) : super(key: key);

  @override
  State<Listbkm> createState() => _Listbkm();
}

class _Listbkm extends State<Listbkm> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        extendBodyBehindAppBar: true,
        body: getBkm());
  }

  int _selectedIndex = -1;

  getBkm() {
    print(AppControl.getBkms().length);
    return ListView.builder(
        itemCount: AppControl.getBkms().length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.black,
            selected: index == _selectedIndex,
            title: Text(AppControl.getBkms()[index].descrizione.toString()),
            subtitle: Text(AppControl.getBkms()[index].link.toString()),
            onTap: () {
              setState(() {
                _selectedIndex = index;

                AppControl.setIndex(index);
                //Navigator.of(context)
                //.push(MaterialPageRoute(builder: (context) => Bookmarks()));
              });
            },
          );
        });
  }
}
