import 'package:flutter/material.dart';
import 'package:untitled/pages/widgets/CardBkm.dart';
import 'package:untitled/theme.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: EdgeInsets.all(64.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomTheme.gradientStart,
            CustomTheme.gradientEnd,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 1.0),
        ),
      ),
      child: Column(
        children: [ CardBkm()

        ],
      ),
    ),
  );
}
