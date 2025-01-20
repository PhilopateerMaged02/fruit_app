import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/models/ReviewsModel/reviews_model.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Reviews extends StatefulWidget {
  @override
  State<Reviews> createState() => _ReviewsState();
  final int product_id;

  const Reviews({
    required this.product_id,
    Key? key,
  }) : super(key: key);
}

class _ReviewsState extends State<Reviews> {
  @override
  void initState() {
    super.initState();
  }

  var commentController = TextEditingController();
  int x = 1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "المراجعه",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            actions: [],
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image(image: AssetImage("assets/images/backArrow.png"))),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!FruitAppCubit.get(context)
                      .reviewsList
                      .contains(FruitAppCubit.get(context).reviewsModel?.uId))
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: NetworkImage(
                                    FruitAppCubit.get(context)
                                        .userModel!
                                        .profile_image),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                    hintText: "اكتب التعليق..",
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    FruitAppCubit.get(context).star1 = true;
                                    FruitAppCubit.get(context).star2 = false;
                                    FruitAppCubit.get(context).star3 = false;
                                    FruitAppCubit.get(context).star4 = false;
                                    FruitAppCubit.get(context).star5 = false;
                                    x = 1;
                                  });
                                },
                                icon: Icon(
                                  FruitAppCubit.get(context).star1
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: FruitAppCubit.get(context).star1
                                      ? Colors.orange
                                      : Colors.black,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    FruitAppCubit.get(context).star1 = true;
                                    FruitAppCubit.get(context).star2 = true;
                                    FruitAppCubit.get(context).star3 = false;
                                    FruitAppCubit.get(context).star4 = false;
                                    FruitAppCubit.get(context).star5 = false;
                                    x = 2;
                                  });
                                },
                                icon: Icon(
                                  FruitAppCubit.get(context).star2
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: FruitAppCubit.get(context).star2
                                      ? Colors.orange
                                      : Colors.black,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    FruitAppCubit.get(context).star1 = true;
                                    FruitAppCubit.get(context).star2 = true;
                                    FruitAppCubit.get(context).star3 = true;
                                    FruitAppCubit.get(context).star4 = false;
                                    FruitAppCubit.get(context).star5 = false;
                                    x = 3;
                                  });
                                },
                                icon: Icon(
                                  FruitAppCubit.get(context).star3
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: FruitAppCubit.get(context).star3
                                      ? Colors.orange
                                      : Colors.black,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    FruitAppCubit.get(context).star1 = true;
                                    FruitAppCubit.get(context).star2 = true;
                                    FruitAppCubit.get(context).star3 = true;
                                    FruitAppCubit.get(context).star4 = true;
                                    FruitAppCubit.get(context).star5 = false;
                                    x = 4;
                                  });
                                },
                                icon: Icon(
                                  FruitAppCubit.get(context).star4
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: FruitAppCubit.get(context).star4
                                      ? Colors.orange
                                      : Colors.black,
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    FruitAppCubit.get(context).star1 = true;
                                    FruitAppCubit.get(context).star2 = true;
                                    FruitAppCubit.get(context).star3 = true;
                                    FruitAppCubit.get(context).star4 = true;
                                    FruitAppCubit.get(context).star5 = true;
                                    x = 5;
                                  });
                                },
                                icon: Icon(
                                  FruitAppCubit.get(context).star5
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: FruitAppCubit.get(context).star5
                                      ? Colors.orange
                                      : Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        buildDefaultButton(
                            text: "أرسال",
                            onPressed: () {
                              print(x);
                              print(widget.product_id);

                              FruitAppCubit.get(context).createReview(
                                  name: FruitAppCubit.get(context)
                                      .userModel!
                                      .name,
                                  image: FruitAppCubit.get(context)
                                      .userModel!
                                      .profile_image,
                                  time: DateTime.now().toString().split(' ')[0],
                                  comment: commentController.text,
                                  rate: x,
                                  product_id: widget.product_id);
                            }),
                        SizedBox(height: 10),
                      ],
                    ),
                  Row(
                    children: [
                      Text(
                        "324",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "مراجعه",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "الملخص",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 50 / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("5"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 50 / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("4"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 75 / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("3"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 25 / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("2"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FractionallySizedBox(
                                widthFactor: 50 / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("1"),
                    ],
                  ),
                  SizedBox(height: 20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildReviewItem(
                        FruitAppCubit.get(context).reviewsList[index]),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: FruitAppCubit.get(context).reviewsList.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildReviewItem(ReviewsModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image),
              radius: 25,
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.orange,
              child: Text(
                model.rate.toString(),
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                model.time,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                model.comment,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
