import 'package:flutter/material.dart';
import '../control/AppControl.dart';
import 'widgets/Listbkm.dart';
import '../theme.dart';
import '../control/BkmsStore.dart';
import '../entity/Bkms.dart';

class Bookmarks extends StatefulWidget {

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  bool isChecked = false;
  final TextEditingController desc = TextEditingController(text: "");
  final TextEditingController link = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(58.0),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              CustomTheme.gradientStart,
              CustomTheme.gradientEnd,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
          )),
          child: Column(
            children: [
              _containerField(),
              const SizedBox(height: 20.0),
              Row(children: [
                Column(
                  children: [_newButton()],
                ),
                const SizedBox(width: 50.0),
                Column(children: [_listButton()])
              ]),
            ],
          ),
        ),
      );

  Widget _containerField() => Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                _descriptionField(),
                _linkField(),
                _checkCondiviso(),
              ],
            ),
          ),
        ),
      );

  Widget _descriptionField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          controller: desc,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci la descrizione',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  Widget _linkField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: TextField(
          controller: link,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Inserisci il link',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
        ),
      );

  Widget _checkCondiviso() => Row(
        children: [
          const SizedBox(width: 28.0),
          const Text(
            'Condiviso',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ],
      );

  Widget _newButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF00C853),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'NUOVO',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
        onPressed: () async {
          var bkms = await BkmsStore.postBkms(
              AppControl.getUser(), desc.text, link.text, isChecked);
          if (bkms != null) {
            print(bkms!.link);
          }
        },
      );

  Widget _listButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF00C853),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'VEDI BKMS',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
        onPressed: () async {
          
          print(AppControl.getUser().token);
          
          var bkms = await BkmsStore.getBkms(AppControl.getUser());
          
          if (bkms != null) {
            print("Retornato tutti Bkms");
          }
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Listbkm()));
        },
      );
}
