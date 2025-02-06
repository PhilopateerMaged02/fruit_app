import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/OrdersModel/orders_model.dart';
import 'package:fruit_app/models/PaymentCreditCardModel/payment_credit_card_model.dart';
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

Future navigatoToWithAnimation(context, widget) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);
        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    ),
  );
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

Widget buildLoginTextField({
  required TextEditingController controller,
  required String text,
  required int maxChar,
  required TextInputType keyboardType,
}) {
  return TextFormField(
    controller: controller,
    maxLength: maxChar,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFE6E9E9), width: 1)),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0XFFE6E9E9),
          width: .2,
        ),
      ),
      fillColor: Color(0xFFF9FAFA),
      filled: true,
    ),
  );
}

Widget buildTextFieldWithSuffix(
    {required TextEditingController controller,
    required String text,
    required Function()? function,
    required IconData icon,
    required bool isEnabled}) {
  return TextFormField(
    controller: controller,
    enabled: isEnabled,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0XFFE6E9E9), width: 1),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0XFFE6E9E9),
          width: .2,
        ),
      ),
      fillColor: Color(0xFFF9FAFA),
      suffixIcon: IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          color: isEnabled ? Colors.green[800] : Colors.grey,
        ),
      ),
      filled: true,
    ),
  );
}

Widget buildFruitItem(BuildContext context, product, Function() functionOfFav) {
  bool isFav = FruitAppCubit.get(context).favItems.contains(product.id);

  return InkWell(
    onTap: () {
      navigatoToWithAnimation(
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
                  onPressed: functionOfFav,
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border_outlined,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
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

Widget buildFruitItemInFav(
    BuildContext context, product, Function() functionOfFav) {
  bool isFav = FruitAppCubit.get(context).favItems.contains(product.id);

  return InkWell(
    onTap: () {
      navigatoToWithAnimation(
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
                  onPressed: functionOfFav,
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
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

Widget buildOrderItem({
  required bool isExpanded,
  required Function toggleExpansion,
  OrdersModel? orderModel,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[100]!,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green[50],
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset("assets/images/closeBox.png"),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("طلب رقم: ${orderModel!.id}#",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Text("تم الطلب :  ${orderModel.date}",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Row(
                        children: [
                          Text("عدد الطلبات : ${orderModel.quantity}",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(width: 20),
                          Text("${orderModel.price} جنية",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    toggleExpansion();
                  },
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: isExpanded ? 250 : 0,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: isExpanded
              ? SingleChildScrollView(
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text("تتبع الطلب",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Spacer(),
                            Text("22 مارس , 2024",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                            height: 30, width: 1, color: Colors.green[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text("قبول الطلب",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Spacer(),
                            Text("22 مارس , 2024",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                            height: 30, width: 1, color: Colors.green[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text("تم شحن الطلب",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Spacer(),
                            Text("22 مارس , 2024",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                            height: 30, width: 1, color: Colors.green[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text("خرج للتوصيل",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Spacer(),
                            Text("22 مارس , 2024",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                            height: 30, width: 1, color: Colors.green[900]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[900],
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text("تم تسليم",
                                style: TextStyle(fontWeight: FontWeight.w700)),
                            Spacer(),
                            Text("22 مارس , 2024",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ],
                  )),
                )
              : SizedBox(),
        ),
      ],
    ),
  );
}

Widget buildCreditCardItem(PaymentCreditCardModel model) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[400]!, width: 1),
      ),
      child: Row(
        children: [
          Spacer(),
          Text(
            "${model.card_no.substring(model.card_no.length - 4)}************",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 50,
              child: model.card_no.startsWith('4')
                  ? Image.asset("assets/images/visablue.png")
                  : Image.asset("assets/images/mastercard.png"),
            ),
          ),
        ],
      ),
    ),
  );
}
