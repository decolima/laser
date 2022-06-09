import 'package:flutter/material.dart';
import 'package:untitled/control/AppControl.dart';
import 'package:untitled/theme.dart';
import '../control/BkmsStore.dart';
import '../entity/bkms.dart';


class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {

  _BookmarksState(){
    _getBkms();
  }


  bool isChecked = false;
  final TextEditingController desc = TextEditingController(text: "");
  final TextEditingController link = TextEditingController(text: "");
  var bkms = <Bkms>[];

  _getBkms() {
    try {
      var usr = appControl.getUser();
      print(usr!.token);
      //bkms = bkmsStore.getBkms(usr!) as List<Bkms>;
/*
      for(var e in bkms){
        print(e.descrizione);
      }
*/
    }
    catch (e) {
      print(e);
    }
  }

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
                Column(children: [_newButton()],),
                const SizedBox(width: 60.0),
                Column(children: [_updateButton()])
              ]),
              const SizedBox(height: 20.0),
              Expanded(
                child: Scaffold(
                    body:_listBkm()
                ),
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

    Widget _linkField() =>  Padding(
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
        SizedBox(width: 28.0),
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
        primary: Color(0xFF00C853),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'NUOVO',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
      onPressed: () => {},
    );

    Widget _updateButton() => ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF00C853),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'AGGIORNA',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ],
      ),
      onPressed: () => {},
    );

    Widget _containerList() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.white,
          child: _listBkm()
      ),
    );

    _listBkm() {
      return ListView.builder(
          itemCount: bkms.length,
          itemBuilder: (context, index) {
            return ListTile(
              focusColor: Colors.white30,
              title: Text(bkms[index].descrizione.toString()),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text(bkms[index].link.toString()), Text(bkms[index].condiviso.toString())]),
              /*onTap: () { Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailPage(bkms)));
              },*/
            );
          });
    }
  }



