import 'package:flutter/material.dart';
import '../../control/AppControl.dart';
import '../../control/BkmsStore.dart';
import '../../control/Listbkm.dart';

class bookmarks extends StatefulWidget {
  @override
  State<bookmarks> createState() => _bookmarksState();
}

class _bookmarksState extends State<bookmarks> {
  _bookmarksState() {
    var resp = BkmsStore.getBkms(AppControl.getUser());
    print(AppControl.getBkms().length);
  }

  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final TextEditingController desc = TextEditingController(text: '');
    final TextEditingController link = TextEditingController(text: '');

    final descriptionField = TextField(
      controller: desc,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Descrizione",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final linkField = TextField(
      controller: link,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Bkm Link",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final btnCreaBkms = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Crea",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          var bkms = await BkmsStore.postBkms(
              AppControl.getUser(), desc.text, link.text, false);
        },
      ),
    );

    final btnListBkms = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Listbkm",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Listbkm()));
        },
      ),
    );

    return Scaffold(
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
            descriptionField,
            const SizedBox(
              height: 40.0,
            ),
            linkField,
            const SizedBox(
              height: 40.0,
            ),
            Row(children: [
              Column(children: [btnCreaBkms]),
              Column(children: [btnListBkms])
            ]),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      )),
    ));
  }
}
