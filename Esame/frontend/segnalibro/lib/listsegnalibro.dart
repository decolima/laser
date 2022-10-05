import 'package:flutter/material.dart';
import 'package:segnalibro/detagli.dart';
import '../../control/AppControl.dart';
import 'entity/User.dart';
import 'login.dart';

class Listbkm extends StatefulWidget {
  const Listbkm({Key? key}) : super(key: key);

  @override
  State<Listbkm> createState() => _Listbkm();
}

class _Listbkm extends State<Listbkm> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("...: Lista di SegnaLibri :..."),
          //automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  User u = User();
                  AppControl.setUser(u);
                  AppControl.clearBkms();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WidgetLogin()));
                })
          ],
        ),
        body: getBkm());
  }

  int _selectedIndex = -1;

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

                AppControl.setIndex(index);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => detaglisl()));
              });
            },
          );
        });
  }
}
