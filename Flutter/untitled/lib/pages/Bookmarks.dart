import 'package:flutter/material.dart';
import 'package:untitled/pages/widgets/CardBkm.dart';
import 'package:untitled/pages/widgets/ListBkm.dart';
import 'package:untitled/theme.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(58.0),
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
              CardBkm(),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [_newButton()],
                  ),
                  Column(
                    children: [_updateButton()],
                  )
                ],
              ),
              SizedBox(height: 20.0),
             Expanded(child: ListBkm())
            ],
          ),
        ),
      );
}

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
