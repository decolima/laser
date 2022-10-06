import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mutuapp/control/MutuaControl.dart';
import 'package:mutuapp/entity/Status.dart';
import 'package:mutuapp/pages/historical_page.dart';

import '../entity/mutua.dart';

class MutuaPage extends StatefulWidget {
  const MutuaPage({Key? key}) : super(key: key);

  @override
  State<MutuaPage> createState() => _MutuaPageState();
}

class _MutuaPageState extends State<MutuaPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDateStart = DateTime.now();
  DateTime _selectedDateEnd = DateTime.now();

  ///scelgo la data
  void getData(int a) async {
    var fDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2018),
        lastDate: DateTime(2030));

    ///aggiorno lo stato
    if (fDate != null) {
      setState(() {
        _selectedDate = fDate;
        if (a == 0) {
          _selectedDateStart = fDate;
        } else {
          _selectedDateEnd = fDate;
        }
      });
    }
  }

  final TextEditingController reason = TextEditingController(text: "");
  final TextEditingController protocolNumber = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final DateFormat df = DateFormat("dd/MM/yyyy");
    return Scaffold(
        appBar: AppBar(
          title: Text("Crea qui la tua Mutua"),
          backgroundColor: Colors.red[800],
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoricalPage()));
                })
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Card(
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "DAL",
                      style: TextStyle(fontSize: 16, color: Colors.red[800]),
                    ),
                    SizedBox(width: 10),
                    Text(df.format(_selectedDateStart)),
                    IconButton(
                        icon: Icon(
                          Icons.date_range,
                          color: Colors.red[800],
                        ),
                        onPressed: () {
                          getData(0);
                        }),
                    SizedBox(width: 60),
                    Text(
                      "AL",
                      style: TextStyle(fontSize: 16, color: Colors.red[800]),
                    ),
                    SizedBox(width: 10),
                    Text(df.format(_selectedDateEnd)),
                    IconButton(
                        icon: Icon(Icons.date_range, color: Colors.red[800]),
                        onPressed: () {
                          getData(1);
                        }),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: Column(
                  children: [
                    _reasonField(),
                    Divider(),
                    _protocolNumberField(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.thermostat,
                        color: Colors.red[800], size: 60),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                  SizedBox(width: 290),
                  FloatingActionButton(
                    onPressed: () {
                      Mutua m = MutuaControl.creaMutua("motivo",
                          _selectedDateStart, _selectedDateEnd, "protocolo123");
                      MutuaControl.addMutua(m);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoricalPage()),
                      );
                    },
                    child: Text("INVIA"),
                    backgroundColor: Colors.red[800],
                  ),
                ],
              )
            ])));
  }

  Widget _reasonField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          controller: reason,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci il motivo',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  Widget _protocolNumberField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          controller: protocolNumber,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci il numero di protocollo ',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Text(
          "Sei sicuro di voler inviare il primo messaggio relativo alla mutua? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
