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
    carica();
  }

  carica() {
    //controllo di mutua in status NEW
    if (MutuaControl.getMutua()
        .where((e) => e.status == Status.NEW)
        .isNotEmpty) {
      if (MutuaControl.getMutuaStatus(Status.NEW).start != null) {
        dt_start_new.text =
            MutuaControl.getMutuaStatus(Status.NEW).start.toString();
        dt_end_new.text =
            MutuaControl.getMutuaStatus(Status.NEW).end.toString();
        protocolNumber_new.text =
            MutuaControl.getMutuaStatus(Status.NEW).protocolNumber.toString();
      } else {
        dt_start_new.text = "";
        dt_end_new.text = "";
        protocolNumber_new.text = "";
      }
    } else {
      dt_start_new.text = "";
      dt_end_new.text = "";
      protocolNumber_new.text = "";
    }

    //Controllo di Mutua in Status InProgress
    if (MutuaControl.getMutua()
        .where((e) => e.status == Status.INPROGRESS)
        .isNotEmpty) {
      if (MutuaControl.getMutuaStatus(Status.INPROGRESS).start != null) {
        dt_start_progress.text =
            MutuaControl.getMutuaStatus(Status.INPROGRESS).start.toString();
        dt_end_progress.text =
            MutuaControl.getMutuaStatus(Status.INPROGRESS).end.toString();
        protocolNumber_progress.text =
            MutuaControl.getMutuaStatus(Status.INPROGRESS)
                .protocolNumber
                .toString();
      } else {
        dt_start_progress.text = "";
        dt_end_progress.text = "";
        protocolNumber_progress.text = "";
      }
    } else {
      dt_start_progress.text = "";
      dt_end_progress.text = "";
      protocolNumber_progress.text = "";
    }

    //Controllo di mutua in status Closed
    if (MutuaControl.getMutua()
        .where((e) => e.status == Status.CLOSED)
        .isNotEmpty) {
      listClosed();
    }
  }

  listClosed() {
    return ListView.builder(
        itemCount: MutuaControl.getMutuaFiltred(Status.CLOSED).length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.blue,
            title: Text(MutuaControl.getMutuaFiltred(Status.CLOSED)[index]
                .protocolNumber
                .toString()),
            subtitle: Text(
                "${MutuaControl.getMutuaFiltred(Status.CLOSED)[index].start.toString()} - ${MutuaControl.getMutuaFiltred(Status.CLOSED)[index].start.toString()} - ${MutuaControl.getMutuaFiltred(Status.CLOSED)[index].reason.toString()}"),
            onTap: () {},
          );
        });
  }

  final TextEditingController dt_start_new = TextEditingController(text: "");
  final TextEditingController dt_end_new = TextEditingController(text: "");
  final TextEditingController protocolNumber_new =
      TextEditingController(text: "");

  final TextEditingController dt_start_progress =
      TextEditingController(text: "");
  final TextEditingController dt_end_progress = TextEditingController(text: "");
  final TextEditingController protocolNumber_progress =
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
                            child: const Text('Status InProgress'),
                            onPressed: () {
                              if (MutuaControl.getMutuaStatus(Status.NEW)
                                      .protocolNumber !=
                                  null) {
                                MutuaControl.aggMutua(
                                    MutuaControl.getMutuaStatus(Status.NEW),
                                    Status.INPROGRESS);
                              }
                              carica();
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Informa Malatia'),
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
                      TextField(controller: dt_start_progress),
                      TextField(controller: dt_end_progress),
                      TextField(controller: protocolNumber_progress),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Cambia Status'),
                            onPressed: () {
                              if (MutuaControl.getMutuaStatus(Status.INPROGRESS)
                                      .protocolNumber !=
                                  null) {
                                MutuaControl.aggMutua(
                                    MutuaControl.getMutuaStatus(
                                        Status.INPROGRESS),
                                    Status.CLOSED);
                              }
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
                child: Card(),
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
