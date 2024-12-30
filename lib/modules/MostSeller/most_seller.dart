import 'package:flutter/material.dart';
import 'package:fruit_app/shared/components.dart';

class MostSeller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "الأكثر مبيعًا",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green[50],
              backgroundImage: AssetImage("assets/images/notification.png"),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image(image: AssetImage("assets/images/backArrow.png"))),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "الأكثر مبيعًا",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              children: [
                buildFruitItem("assets/images/fruit1.png"),
                buildFruitItem("assets/images/fruit2.png"),
                buildFruitItem("assets/images/fruit3.png"),
                buildFruitItem("assets/images/fruit4.png"),
                buildFruitItem("assets/images/fruit5.png"),
                buildFruitItem("assets/images/fruit2.png"),
                buildFruitItem("assets/images/fruit3.png"),
                buildFruitItem("assets/images/fruit4.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
