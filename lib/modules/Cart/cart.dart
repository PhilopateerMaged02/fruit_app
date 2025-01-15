import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/models/CartModel/cart_model.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/modules/Home/home.dart';
import 'package:fruit_app/modules/Products/products.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

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
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
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
                onTap: () {
                  navigateTo(context, FruitappLayout());
                },
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
                      Text(
                          FruitAppCubit.get(context)
                              .cartItems
                              .length
                              .toString(),
                          style: TextStyle(color: Colors.green[700])),
                      Text(" منتجات في سلة التسوق",
                          style: TextStyle(color: Colors.green[700])),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (FruitAppCubit.get(context).cartItems.length == 0 ||
                  state is FruitAppGetCartDataError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 200),
                  child: Center(
                    child: Text(
                      "السلة فارغة",
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              if (FruitAppCubit.get(context).cartItems.length != 0 ||
                  state is FruitAppGetCartDataSuccess)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildFruitCartItem(
                          FruitAppCubit.get(context).cartItems[index]),
                      separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: 1,
                              color: Colors.grey[300],
                              width: double.infinity,
                            ),
                          ),
                      itemCount: FruitAppCubit.get(context).cartItems.length),
                ),
              if (FruitAppCubit.get(context).cartItems.length > 0)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildDefaultButton(
                      text:
                          "الدفع ${"${FruitAppCubit.get(context).finalPrice.toString()} جنية"}",
                      onPressed: () {}),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFruitCartItem(CartModel cartModel) {
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
                child: Image(image: NetworkImage(cartModel.image))),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.name,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  cartModel.quantity.toString() + " كم",
                  style: TextStyle(
                      color: Colors.yellow[700], fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          FruitAppCubit.get(context).increaseItemInCart(
                              cartModel.product_id,
                              cartModel.quantity,
                              cartModel.name,
                              cartModel.image,
                              cartModel.price,
                              cartModel.id);
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green[800],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage("assets/images/plus.png")),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        cartModel.quantity.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          FruitAppCubit.get(context).decreaseItemInCart(
                              cartModel.product_id,
                              cartModel.quantity,
                              cartModel.name,
                              cartModel.image,
                              cartModel.price,
                              cartModel.id);
                        },
                        child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage("assets/images/minus.png")),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    FruitAppCubit.get(context).removeFromCart(
                        cartModel.id, cartModel.quantity, cartModel.product_id);
                  },
                  child: Image(
                      width: 20,
                      height: 20,
                      image: AssetImage("assets/images/trash.png")),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  (cartModel.price * cartModel.quantity).toString() + " جنية",
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
