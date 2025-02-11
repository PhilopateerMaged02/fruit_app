import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/modules/FruitItemDetail/fruit_item_detail.dart';
import 'package:fruit_app/shared/components.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final int id;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.id});
}

class Filters extends StatefulWidget {
  final List<ProductsModel> productList;
  final double min;
  final double max;
  Filters({required this.productList, required this.min, required this.max});

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var searchController = TextEditingController();
  List<ProductsModel> filtersResults = [];

  @override
  Widget build(BuildContext context) {
    filtersResults = widget.productList
        .where((product) =>
            product.price >= widget.min && product.price <= widget.max)
        .toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image(
                        image: AssetImage("assets/images/backArrow.png"))),
                Spacer(),
                Text(
                  "التصفية",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green[50],
                  backgroundImage: AssetImage("assets/images/notification.png"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    '${filtersResults.length} نتاج',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                  )
                ],
              ),
            ),
            Expanded(
              child: filtersResults.isEmpty
                  ? Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image(
                            image: AssetImage("assets/images/searcherror.jpg")),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: filtersResults.length,
                      itemBuilder: (context, index) {
                        return buildFruitItem(context, filtersResults[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFruitItem(context, ProductsModel product) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            FruitItemDetail(
                id: product.id,
                image: product.image,
                name: product.name,
                price: product.price));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
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
                child: Image.network(product.image),
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
                              "${product.price}",
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
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
}
