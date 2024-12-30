import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToust({
  required String? message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    backgroundColor: chooseToastColor(state),
    fontSize: 16,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
  );
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future navigateTo(context, widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

Future navigateToandKill(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget buildFruitItem(String image) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Container(
      height: 500,
      color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
            ],
          ),
          Container(
            width: 90,
            height: 90,
            child: Image(
              image: AssetImage(image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "فراولة",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "30جنية / الكيلو",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.yellow[700]),
                  ),
                ]),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: CircleAvatar(
                    backgroundColor: Colors.green[800],
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
