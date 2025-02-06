import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/shared/components.dart';

class NonSuccessPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
                width: 200,
                height: 200,
                child: Image(image: AssetImage("assets/images/errorr.png"))),
          ),
          Center(
              child: Text(
            "حدث خطا في الدفع!",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          )),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              navigateTo(context, FruitappLayout());
            },
            child: Center(
                child: Text(
              "الرئيسية",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: Colors.green[800],
                  decoration: TextDecoration.underline),
            )),
          ),
        ],
      ),
    );
  }
}
