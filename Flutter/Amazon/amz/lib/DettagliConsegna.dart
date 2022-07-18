import '../../control/AppControl.dart';
import 'package:flutter/material.dart';
import 'ListConsegna.dart';
import 'entity/User.dart';
import 'login.dart';

class DettagliConsegna extends StatefulWidget {
  @override
  State<DettagliConsegna> createState() => _DettagliConsegna();
}

class _DettagliConsegna extends State<DettagliConsegna> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final TextEditingController idamz = TextEditingController(
        text: AppControl.getConsegna()[AppControl.getIndex()].idamazon);
    final TextEditingController dim = TextEditingController(
        text: AppControl.getConsegna()[AppControl.getIndex()].dimensione);
    final TextEditingController pes = TextEditingController(
        text: AppControl.getConsegna()[AppControl.getIndex()]
            .pesopaco
            .toString());
    final TextEditingController ind = TextEditingController(
        text: AppControl.getConsegna()[AppControl.getIndex()].indirizzo);

    final IdAmazonField = TextField(
      controller: idamz,
      style: style,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final DimensioneField = TextField(
      controller: dim,
      style: style,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final PesoField = TextField(
      controller: pes,
      style: style,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final IndirizzoField = TextField(
      controller: ind,
      style: style,
      enabled: false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final buttonConsegnato = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Delivered",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          await AppControl.AggConsegna("Consegnata");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DoListConsegna()));
        },
      ),
    );

    final buttonRitornato = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Retorned",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          await AppControl.AggConsegna("Restituita");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DoListConsegna()));
        },
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("..: Order Details :.."),
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
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                  child: Text(
                    "Seller ID",
                  ),
                ),
                IdAmazonField,
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                  child: Text(
                    "Sizes",
                  ),
                ),
                DimensioneField,
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                  child: Text(
                    "Weight",
                  ),
                ),
                PesoField,
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                  child: Text(
                    "Address",
                  ),
                ),
                IndirizzoField,
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    const SizedBox(width: 100.0),
                    buttonConsegnato,
                    const SizedBox(width: 70.0),
                    buttonRitornato
                  ],
                ),
              ],
            ),
          )),
        ));
  }
}
