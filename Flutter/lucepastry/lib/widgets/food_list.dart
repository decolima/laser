import 'package:flutter/material.dart';

import '../models/pastry.dart';

class FoodList extends StatelessWidget {
  final int selected;
  final Function callBack;
  final Pastry pastry;
  FoodList(this.selected, this.callBack, this.pastry);

  @override
  Widget build(BuildContext context) {
    final category = pastry.menu.keys.toList();
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 30),
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => callBack(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:
                        selected == index ? Colors.pink : Colors.white,
                  ),
                  child: Text(
                    category[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          separatorBuilder: (_, index) => SizedBox(width: 20),
          itemCount: category.length),
    );
  }
}
