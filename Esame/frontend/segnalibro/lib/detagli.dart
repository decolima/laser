import '../../control/AppControl.dart';
import 'package:flutter/material.dart';

import 'entity/User.dart';
import 'listsegnalibro.dart';
import 'login.dart';

class detaglisl extends StatefulWidget {
  @override
  State<detaglisl> createState() => _detaglislState();
}

class _detaglislState extends State<detaglisl> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    final TextEditingController desc = TextEditingController(
        text:
            AppControl.getBkms()[AppControl.getIndex()].descrizione.toString());

    final TextEditingController condiviso = TextEditingController(text: '');

    final TextEditingController link = TextEditingController(
        text: AppControl.getBkms()[AppControl.getIndex()].link.toString());

    final TextEditingController tags = TextEditingController(
        text: AppControl.getBkms()[AppControl.getIndex()].tags.toString());

    final descField = TextField(
      controller: desc,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Descrizione SegnaLibro",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final linkField = TextField(
      controller: link,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Link SegnaLibro",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final tagField = TextField(
      controller: tags,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Tags # Tags # Tags",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final condivisoField = TextField(
      controller: condiviso,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "1 COndiviso - 0 Particolare",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final buttonSegnaLibri = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Lista SL",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          if (AppControl.getUser()!.firstName != null) {
            await AppControl.CaricaSegnaLibro();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Listbkm()));
          }
        },
      ),
    );

    final buttonCrea = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
          child: const Text(
            "Crea SL",
            textAlign: TextAlign.center,
          ),
          onPressed: () async {
            bool cond = false;
            if (AppControl.getUser()!.firstName != null) {
              if (condiviso.text == "1") cond = true;

              await AppControl.CreaSegnaLibro(
                  desc.text, link.text, cond, tags.text);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Listbkm()));
            }
          }),
    );

    final buttonAgg = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
          child: const Text(
            "Agg SL",
            textAlign: TextAlign.center,
          ),
          onPressed: () async {
            if (AppControl.getUser()!.firstName != null) {
              await AppControl.AggSegnaLibro(
                  desc.text, link.text, isChecked, tags.text);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Listbkm()));
            }
          }),
    );

    final buttonDel = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
          child: const Text(
            "Canc. SL",
            textAlign: TextAlign.center,
          ),
          onPressed: () async {
            if (AppControl.getUser()!.firstName != null) {
              await AppControl.delSegnaLibro();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Listbkm()));
            }
          }),
    );

    final buttonClear = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
          child: const Text(
            "Crea SL",
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            desc.text = "";
            link.text = "";
            tags.text = "";
          }),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("...: Gestisce il SegnaLibro :..."),
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
        body: Center(
          child: SingleChildScrollView(
              child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                descField,
                const SizedBox(
                  height: 40.0,
                ),
                linkField,
                const SizedBox(
                  height: 40.0,
                ),
                tagField,
                const SizedBox(
                  height: 40.0,
                ),
                condivisoField,
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    const SizedBox(width: 100.0),
                    buttonSegnaLibri,
                    const SizedBox(width: 70.0),
                    buttonCrea
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    const SizedBox(width: 100.0),
                    buttonAgg,
                    const SizedBox(width: 70.0),
                    buttonDel
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [const SizedBox(width: 100.0), buttonClear],
                ),
              ],
            ),
          )),
        ));
  }
}
