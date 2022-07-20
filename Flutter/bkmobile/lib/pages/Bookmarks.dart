import 'package:flutter/material.dart';
import 'package:untitled/pages/welcome_page.dart';
import 'package:untitled/pages/widgets/sign_in.dart';
import '../control/AppControl.dart';
import '../entity/User.dart';
import 'widgets/Listbkm.dart';
import '../control/BkmsStore.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

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

      isVNew = false;
      isVUpt = true;
      isVDel = true;
      isVClear = true;
    } else {
      isVNew = true;
      isVUpt = false;
      isVDel = false;
      isVClear = false;
    }
  }

  bool isChecked = false;
  bool isVNew = true;
  bool isVUpt = true;
  bool isVDel = true;
  bool isVClear = true;
  final TextEditingController desc = TextEditingController(text: "");
  final TextEditingController link = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  User u = User(
                      userid: 0,
                      firstName: "",
                      lastName: "",
                      mail: "",
                      role: "",
                      token: "",
                      error: "");

                  AppControl.setUser(u);
                  AppControl.clearBkms();
                  AppControl.setIndex(-1);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                })
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          margin: EdgeInsets.only(top: 32.0),
            padding: const EdgeInsets.all(58.0),
            decoration:
                const BoxDecoration(color: Color.fromRGBO(225, 237, 249, 1.0)),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _containerField()),
                const SizedBox(height: 20.0),
                Row(children: [
                  _listButton(),
                  const SizedBox(width: 50.0),
                  Visibility(
                    visible: isVNew,
                    child: _newButton(),
                  ),
                  Visibility(
                    visible: isVClear,
                    child: _clearButton(),
                  ),
                ]),
                const SizedBox(height: 20.0),
                Row(children: [
                  Visibility(
                    visible: isVUpt,
                    child: _updateButton(),
                  ),
                  const SizedBox(width: 50.0),
                  Visibility(
                    visible: isVDel,
                    child: _deleteButton(),
                  ),
                ])
              ],
            )),
      );

  Widget _containerField() => Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            _descriptionField(),
            _linkField(),
            _checkCondiviso(),
          ],
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
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'VEDI LINKS',
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
        primary: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
          bkms = await BkmsStore.putBkms(u, i, desc.text, link.text, isChecked);
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SignIn()));
        }
        if (bkms == null) {
          _showDialogBkm();
        } else {
          AppControl.clearBkms();
          bkms = await BkmsStore.getBkms(u);
          AppControl.setIndex(-1);
          desc.text = "";
          link.text = "";
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Bookmarks()));
          _showDlgAggBkm;
        }
      });

  Widget _deleteButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
        onPressed: () async {
          var u = AppControl.getUser();
          var bkms;
          if (u != null || u!.userid != 0) {
            int index = AppControl.getIndex();
            var i = AppControl.getBkms()[index].idbkm.toString();
            bkms = await BkmsStore.delBkms(u, i);
          } else {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignIn()));
          }

          if (bkms == null) {
            _showDialogErrorDel();
          } else {
            AppControl.clearBkms();
            bkms = await BkmsStore.getBkms(u);
            AppControl.setIndex(-1);
            desc.text = "";
            link.text = "";
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Bookmarks()));
            _showDlgDelBkm();
          }
        },
      );

  Widget _clearButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'PULISCI',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
        onPressed: () {
          desc.text = "";
          link.text = "";
          AppControl.setIndex(-1);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Bookmarks()));
        },
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
                Text('Non sono presenti links per te'),
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
                Text('Link aggiornato con successo !!!'),
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
                Text('Link creato con successo !!!'),
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

  Future<void> _showDialogErrorDel() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mi dispiace'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Non è possibile eliminare il link selezionato'),
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

  Future<void> _showDlgDelBkm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ottimo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('il tuo link è stato cancellato con successo!'),
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
