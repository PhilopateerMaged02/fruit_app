import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/modules/Cart/cart.dart';
import 'package:fruit_app/modules/FruitItemDetail/fruit_item_detail.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';

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

Widget buildDefaultButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    height: 54,
    width: double.infinity,
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(16)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

Widget buildFruitItem(BuildContext context, product) {
  return InkWell(
    onTap: () {
      navigateTo(
        context,
        FruitItemDetail(
          image: product.image,
          name: product.name,
          price: product.price,
          id: product.id,
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 500,
        color: Colors.grey[100],
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border_outlined),
                ),
              ],
            ),
            Container(
              width: 80,
              height: 80,
              child: Image(
                image: NetworkImage(product.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            product.price.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            ),
                          ),
                          Text(
                            "جنية/كيلو",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: CircleAvatar(
                      backgroundColor: Colors.green[800],
                      child: IconButton(
                        onPressed: () {
                          if (FruitAppCubit.get(context)
                              .cartItems
                              .contains(product.id)) {
                            navigateTo(context, Cart());
                          } else if (product.quantity == 0) {
                            showToust(
                              message: "Out of Stock",
                              state: ToastStates.ERROR,
                            );
                          } else {
                            FruitAppCubit.get(context).addtocart(
                              product.id,
                              1,
                              product.name,
                              product.image,
                              product.price,
                            );
                          }
                        },
                        icon: Icon(
                          FruitAppCubit.get(context)
                                  .cartItems
                                  .contains(product.id)
                              ? Icons.shopping_cart_checkout
                              : Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
