import 'package:flutter/material.dart';
import 'package:fruit_app/shared/components.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          "السلة",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {},
            child: Image(image: AssetImage("assets/images/backArrow.png"))),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "لديك ",
                    style: TextStyle(color: Colors.green[700]),
                  ),
                  Text("2", style: TextStyle(color: Colors.green[700])),
                  Text(" منتجات في سلة التسوق",
                      style: TextStyle(color: Colors.green[700])),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => buildFruitCartItem(),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 1,
                        color: Colors.grey[300],
                        width: double.infinity,
                      ),
                    ),
                itemCount: 10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildDefaultButton(
                text: "الدفع ${"120 جنية"}", onPressed: () {}),
          )
        ],
      ),
    );
  }

  Widget buildFruitCartItem() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Colors.grey[200],
                width: 80,
                height: 80,
                child: Image(image: AssetImage("assets/images/banana.png"))),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "بطيخ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  "3 كم",
                  style: TextStyle(
                      color: Colors.yellow[700], fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green[800],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                image: AssetImage("assets/images/plus.png")),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        x.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                image: AssetImage("assets/images/minus.png")),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Image(
                      width: 20,
                      height: 20,
                      image: AssetImage("assets/images/trash.png")),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "60جنية",
                  style: TextStyle(
                      color: Colors.yellow[700], fontWeight: FontWeight.w700),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
