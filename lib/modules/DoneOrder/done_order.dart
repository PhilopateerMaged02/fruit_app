import 'package:flutter/material.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/TrackOrder/track_order.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';

class DoneOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "حاله الطلب",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image(image: AssetImage("assets/images/backArrow.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Center(
              child: Container(
                  width: 200,
                  height: 200,
                  child: Image(image: AssetImage("assets/images/done.png")))),
          Text(
            "تم بنجاح!",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                Spacer(),
                Text(
                  "رقم الطلب : ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                ),
                Text(
                  "123131312312",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: Colors.grey),
                ),
                Text(
                  "#",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: Colors.grey),
                ),
                Spacer(),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildDefaultButton(
                text: "تتبع الطلب",
                onPressed: () {
                  navigateTo(context, TrackOrder());
                }),
          ),
          InkWell(
            onTap: () {
              navigateToandKill(context, FruitappLayout());
            },
            child: Text(
              "الرئيسية",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
            ),
          ),
          Spacer()
        ],
      ),
    );
  }
}
