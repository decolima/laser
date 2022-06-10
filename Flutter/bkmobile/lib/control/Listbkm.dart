import 'BkmsStore.dart';
import 'appControl.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class Listbkm extends StatefulWidget {
  @override
  State<Listbkm> createState() => _Listbkm();
}

class _Listbkm extends State<Listbkm> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
    extendBodyBehindAppBar: true,
    body: SingleChildScrollView(
    child: Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.height,

    padding: const EdgeInsets.all(64.0),
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    colors: [
    CustomTheme.gradientStart,
    CustomTheme.gradientEnd,
    ],
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 1.0),
    ),
    ),
    child: Column(
    children: [getBkm()]
    )
    ),
    ),
    );
  }

  int _selectedIndex = -1;

  _getBkm()  {
    if (appControl.getUser() != null) {
      bkmsStore.getBkms(appControl.getUser());
    }
    else
    {
      print("User non trovato");
    }
  }

  _Listbkm() {
   // _getBkm();
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
