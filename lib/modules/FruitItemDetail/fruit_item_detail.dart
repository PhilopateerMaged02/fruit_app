import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/models/ProductsModel/products_model.dart';
import 'package:fruit_app/modules/Cart/cart.dart';
import 'package:fruit_app/modules/Products/products.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class FruitItemDetail extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final String price;

  const FruitItemDetail({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<FruitItemDetail> createState() => _FruitItemDetailState();
}

class _FruitItemDetailState extends State<FruitItemDetail> {
  @override
  void initState() {
    super.initState();
  }

  int x = 0;
  bool flagSuccess = false;
  bool flagError = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {
        if (state is FruitAppAddToCartSuccess) {
          flagSuccess = true;
          flagError = false;
        } else if (state is FruitAppAddToCartError) {
          flagError = true;
          flagSuccess = false;
        }
      },
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400,
                          child:
                              Image.asset("assets/images/fruitBackground.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/backArrow.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 80),
                          child: Container(
                            width: 250, // Adjusted width
                            height: 250, // Adjusted height
                            child: Image.network(widget.image),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    widget.price,
                                    style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "جنية/كيلو",
                                    style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: CircleAvatar(
                              backgroundColor: Colors.green[800],
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      x++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Text(
                            x.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (x > 0) x--;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "4.5",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "(+30)",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "المراجعة",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        "ينتمي إلى الفصيلة القرعية ولثمرته لُب حلو المذاق وقابل للأكل، وبحسب علم النبات فهي تعتبر ثمار لبيّة، تستعمل لفظة البطيخ للإشارة إلى النبات نفسه أو إلى الثمرة تحديداً",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "عام",
                                          style: TextStyle(
                                              color: Colors.green[500],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "الصلاحية",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/calendar.png")))
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 50,
                          // ),
                          Spacer(),
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "100%",
                                          style: TextStyle(
                                              color: Colors.green[500],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "اورجانيك",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/Group.png")))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "80 كالوري",
                                          style: TextStyle(
                                              color: Colors.green[500],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "100 جرام",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/fire.png")))
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: 50,
                          // ),
                          Spacer(),
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "(256)",
                                              style: TextStyle(
                                                  color: Colors.green[500],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              " 4.5",
                                              style: TextStyle(
                                                  color: Colors.green[500],
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Reviews",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/favourites.png")))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            FruitAppCubit.get(context).addtocart(
                                widget.id, x, widget.name, widget.image);
                          },
                          child: const Text(
                            'أضف الي السلة',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ],
                ),
              ),
              if (flagSuccess)
                Center(
                  child: Container(
                    width: 300,
                    height: 250,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image(
                                image: AssetImage("assets/images/done.png")),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, left: 50, right: 50, bottom: 20),
                          child: SizedBox(
                              child: buildDefaultButton(
                                  text: "الي السلة",
                                  onPressed: () {
                                    navigateTo(context, Cart());
                                    setState(() {});
                                    flagSuccess = false;
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
              if (flagError)
                Center(
                  child: Container(
                    width: 300,
                    height: 250,
                    color: Colors.grey[200],
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/close.png")),
                                ),
                              ),
                              Text(
                                "حدث خطا",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {});
                              flagError = false;
                            },
                            icon: Container(
                              width: 30,
                              height: 30,
                              child: Image(
                                  image: AssetImage("assets/images/close.png")),
                            ))
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
