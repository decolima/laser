import 'package:flutter/material.dart';
import 'package:untitled/App.dart';
import 'package:untitled/pages/widgets/sign_in.dart';
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

  @override
  void initState() {
    super.initState();
    if (AppControl.getIndex() != -1) {
      desc.text =
          AppControl.getBkms()[AppControl.getIndex()].descrizione.toString();
      link.text = AppControl.getBkms()[AppControl.getIndex()].link.toString();
    }
  }

  bool isChecked = false;
  final TextEditingController desc = TextEditingController(text: "");
  final TextEditingController link = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
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
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Column(
                    children: [_updateButton()],
                  ),
                  const SizedBox(width: 50.0),
                  Column(
                    children: [Visibility(
                        child:_deleteButton(),
                        visible: false)
                      ],
                  )
                ],
              )
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
          var u = AppControl.getUser();
          if (u != null || u!.userid != 0) {
            await BkmsStore.postBkms(u, desc.text, link.text, isChecked);
            desc.text = "";
            link.text = "";
            _showDlgNewBkm();
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignIn()));
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
          var u = AppControl.getUser();
          var bkms;
          if (u != null || u!.userid != 0) {
            print(AppControl.getBkms().length);
            AppControl.clearBkms();
            print(AppControl.getBkms().length);
            bkms = await BkmsStore.getBkms(u);



          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignIn()));
          }
          if (bkms == null) {
            _showDialogBkm();
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Listbkm()));
          }
        },
      );

  Widget _updateButton() => ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF00C853),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'AGGIORNA',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
      onPressed: () async {
        var u = AppControl.getUser();
        var bkms;

        if (u != null || u!.userid != 0) {

          int index = AppControl.getIndex();
          var i = AppControl.getBkms()[index].idbkm.toString();
          bkms = await BkmsStore.putBkms(u,i, desc.text, link.text, isChecked);

        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignIn()));
        }
        if (bkms == null) {
          _showDialogBkm();
        } else {
          AppControl.clearBkms();
          bkms = await BkmsStore.getBkms(u);
          AppControl.setIndex(-1);
          desc.text = "";
          link.text = "";
          _showDlgAggBkm;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Listbkm()));
        }
      });

  Widget _deleteButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF00C853),
        ),

        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'ELIMINA',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
        onPressed: () {},
      );

  Future<void> _showDialogBkm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mi dispiace'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Non sono presenti Bookmarks per te'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDlgAggBkm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complimenti'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bookmark aggiornato con successo !!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDlgNewBkm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complimenti'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Bookmark creato con successo !!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
