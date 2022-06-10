import 'package:flutter/material.dart';
import '../entity/User.dart';
import '../service/rest.dart';

class DoListUtenti extends StatefulWidget {
  @override
  State<DoListUtenti> createState() => _DoListUtenti();
}

class _DoListUtenti extends State<DoListUtenti> {
  var users = <User>[];

  _getUsers() {
    try {
      rest.getRest("/users/allslice", false, "").then((response) {
        setState(() {
          for (var e in response) {
            users.add(User.fromJsonSlice(e));
          }
        });
      });
    } catch (e) {
      print("Problema ao carregar Utenti ...");
    }
  }

  _DoListUtenti() {
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista Utenti"),
        ),
        body: getUtenti());
  }

  int _selectedIndex = -1;
  getUtenti() {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            selectedColor: Colors.blue,
            selected: index == _selectedIndex,
            title: Text(users[index].firstName.toString()),
            subtitle: Text(users[index].link.toString()),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
