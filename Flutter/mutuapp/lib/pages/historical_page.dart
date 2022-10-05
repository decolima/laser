import 'package:flutter/material.dart';
import 'package:mutuapp/control/MutuaControl.dart';
import 'package:mutuapp/entity/Status.dart';
import 'package:mutuapp/pages/mutua_page.dart';
import '../control/MutuaControl.dart';
import '../entity/mutua.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({Key? key}) : super(key: key);

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  @override
  void initState() {
    super.initState();
    print("Passa por InitState");
    carica();
  }

  carica() {
    print("fatto la carica");

    if (MutuaControl.getMutua().isNotEmpty) {
      Mutua n = Mutua.create();
      n = MutuaControl.getMutuaStatus(Status.NEW);

      if (n.start != null) {
        dt_start_new.text = n.start.toString();
        dt_end_new.text = n.end.toString();
        protocolNumber_new.text = n.protocolNumber.toString();
      } else {
        print("non c'è una new");
      }
    }
  }

  bool b = false;

  final TextEditingController dt_start_new = TextEditingController(text: "");
  final TextEditingController dt_end_new = TextEditingController(text: "");
  final TextEditingController protocolNumber_new =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Storico della Mutua'),
          backgroundColor: Colors.red[800],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MutuaPage()));
            },
            backgroundColor: Colors.red[800],
            child: const Icon(Icons.add)),
        drawer: _myDrawerWithAccountHeader(context),
        body: Column(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(controller: dt_start_new),
                      TextField(controller: dt_end_new),
                      TextField(controller: protocolNumber_new),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Ok Status'),
                            onPressed: () {
                              carica();
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Cambia Status'),
                            onPressed: () {
                              carica();
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(),
                      TextField(),
                      TextField(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        title: Text('Closed'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}

Widget _myDrawerWithAccountHeader(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/logo_laser.png'))),
          accountName: const Text(
            "User",
            style: TextStyle(color: Colors.black),
          ),
          accountEmail: const Text(
            "Email",
            style: TextStyle(color: Colors.black),
          ),
          currentAccountPicture: Row(
            children: [
              CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Historical'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
      ],
    ),
  );
}
