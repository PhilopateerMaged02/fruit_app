import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/modules/FruitItemDetail/fruit_item_detail.dart';
import 'package:fruit_app/modules/MostSeller/most_seller.dart';
import 'package:fruit_app/modules/Search/search.dart';
import 'package:fruit_app/modules/notifications/notifications.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // State management for the price range values
  RangeValues _currentRangeValues = RangeValues(20, 80);
  double _minPrice = 0;
  double _maxPrice = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Container(),
            centerTitle: true,
            title: Text(
              "المنتجات",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, Notifications());
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green[50],
                    backgroundImage:
                        AssetImage("assets/images/notification.png"),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, Search());
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.05),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/searchnormal.png"),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "ابحث عن ...",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Spacer(),
                                Image(
                                  image:
                                      AssetImage("assets/images/setting-4.jpg"),
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "منتجاتنا",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showFilterBottomSheet(context);
                          },
                          child: Container(
                              width: 50,
                              height: 50,
                              child: Image(
                                  image:
                                      AssetImage("assets/images/filter.png"))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildSmallFruitItem(
                        FruitAppCubit.get(context).productsList[index]),
                    separatorBuilder: (context, index) => Container(
                          width: 15,
                        ),
                    itemCount: FruitAppCubit.get(context).productsList.length),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "الأكثر مبيعًا",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        navigateTo(context, MostSeller());
                      },
                      child: Text(
                        "المزيد",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: SizedBox(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 4, // Number of products
                      itemBuilder: (context, index) {
                        final product = FruitAppCubit.get(context).productsList[
                            index]; // Get the product at the current index
                        return buildFruitItem(
                            context, product); // Pass product to the widget
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSmallFruitItem(ProductsModel product) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            FruitItemDetail(
              image: product.image,
              name: product.name,
              price: product.price,
              id: product.id,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[400],
              backgroundImage: NetworkImage(product.image),
            ),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjusts to content height
            children: [
              Container(
                width: 60,
                height: 2,
                color: Colors.black,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "تصنيف حسب :",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.filter_list),
                title: Text("تصنيف"),
                onTap: () {
                  buildBottomSheetPrice(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.filter_alt),
                title: Text("ترتيب"),
                onTap: () {
                  buildBottomSheetAtoZPrice(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void buildBottomSheetPrice(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: 60,
                      height: 2,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "تصنيف حسب :",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            child: Image(
                                image: AssetImage("assets/images/tag.png"))),
                        SizedBox(width: 10),
                        Text(
                          "السعر :",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 40,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            initialValue: _minPrice.toString(),
                            onChanged: (value) {
                              _minPrice = double.tryParse(value) ?? 0;
                            },
                            decoration: InputDecoration(
                              hintText: "0",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "الي",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 120,
                          height: 40,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            initialValue: _maxPrice.toString(),
                            onChanged: (value) {
                              _maxPrice = double.tryParse(value) ?? 100;
                            },
                            decoration: InputDecoration(
                              hintText: "100",
                              hintStyle: TextStyle(color: Colors.grey[700]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RangeSlider(
                            values: _currentRangeValues,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            labels: RangeLabels(
                              _currentRangeValues.start.toStringAsFixed(0),
                              _currentRangeValues.end.toStringAsFixed(0),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 54,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'تصفيه',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void buildBottomSheetAtoZPrice(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Adjusts to content height
                children: [
                  Container(
                    width: 60,
                    height: 2,
                    color: Colors.black,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "ترتيب حسب :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value: FruitAppCubit.get(context).radio1,
                              groupValue: true,
                              onChanged: (bool? value) {
                                setState(() {});
                                FruitAppCubit.get(context).changeRadio1();
                              }),
                          Text(
                            "السعر ( الأقل الي الأعلي )",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value: FruitAppCubit.get(context).radio2,
                              groupValue: true,
                              onChanged: (bool? value) {
                                setState(() {});
                                FruitAppCubit.get(context).changeRadio2();
                              }),
                          Text(
                            "السعر ( الأعلي الي الأقل )",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value: FruitAppCubit.get(context).radio3,
                              groupValue: true,
                              onChanged: (bool? value) {
                                setState(() {});
                                FruitAppCubit.get(context).changeRadio3();
                              }),
                          Text(
                            "الأبجديه",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 54,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'تصفيه',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
