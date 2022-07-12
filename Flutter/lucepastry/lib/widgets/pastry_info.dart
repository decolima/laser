import 'package:flutter/material.dart';

import '../models/pastry.dart';

class PastryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastry = Pastry.generatePastry();
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pastry.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(pastry.waitTime,
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 10),
                        Text(
                          pastry.label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(pastry.logoUrl, width: 80),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '"${pastry.desc}"',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline, color: Colors.yellowAccent),
                    Text(
                      '${pastry.score}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
