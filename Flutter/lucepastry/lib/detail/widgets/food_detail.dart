import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/food.dart';
import 'food_quantity.dart';

class FoodDetail extends StatelessWidget {
  final Food food;

  FoodDetail(this.food);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            food.name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconText(
                  Icons.access_time_outlined, Colors.blue, food.waitTime),
              _buildIconText(
                  Icons.star_outline, Colors.amber, food.score.toString()),
              _buildIconText(
                  Icons.local_fire_department_outlined, Colors.red, food.cal)
            ],
          ),
          const SizedBox(height: 30),
          FoodQuantity(food),
          const SizedBox(height: 30),
          Row(
            children: const [
              Text(
                'Ingredienti',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          SizedBox(height: 10),
          _CarouselSlider(),
          SizedBox(height: 30),
          Row(
            children: const [
              Text(
                'Breve storia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 10),
          Text(
            food.about,
            style: TextStyle(wordSpacing: 1.2, height: 1.5, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget _CarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 70,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2)),
      items: food.ingredients.map((e) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              child: Column(children: [
                Image.asset(e.values.first, width: 52, height: 52),
                Text(e.keys.first)
              ]),
            );
          },
        );
      }).toList(),
    );
  }
}
