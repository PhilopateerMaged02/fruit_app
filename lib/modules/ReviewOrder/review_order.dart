import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/Address/address.dart';
import 'package:fruit_app/modules/DoneOrder/done_order.dart';
import 'package:fruit_app/modules/Payment/payment.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class ReviewOrder extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green[900],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "الشحن",
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green[900],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "العنوان",
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green[900],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "الدفع",
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green[900],
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "المراجعه",
                        style: TextStyle(
                            color: Colors.green[900],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "ملخص الطلب : ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FruitAppCubit.get(context).pay2!
                          ? Colors.green[900]!
                          : Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("المجموع الفرعي :"),
                            Spacer(),
                            Text("150 جنيه"),
                          ],
                        ),
                        Row(
                          children: [
                            Text("التوصيل : "),
                            Spacer(),
                            Text("150 جنيه"),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: 200,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "الكلي : ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Text(
                              "150 جنيه",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "يرجي تأكيد  طلبك",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FruitAppCubit.get(context).pay2!
                          ? Colors.green[900]!
                          : Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "وسيلة الدفع",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                navigateTo(context, Payment());
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 20,
                                      height: 20,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/edit.png'))),
                                  Text("تعديل"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (FruitAppCubit.get(context).pay1 == false &&
                            FruitAppCubit.get(context).pay2 == true)
                          Row(
                            children: [
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("**** **** **** 6522"),
                              ),
                              InkWell(
                                onTap: () {
                                  FruitAppCubit.get(context)
                                      .changePaymentMethodToVisa();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: FruitAppCubit.get(context).visa!
                                          ? Colors.green[900]!
                                          : Colors.grey[300]!,
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    color: Colors.blue[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                          image: AssetImage(
                                              "assets/images/visa.png")),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (FruitAppCubit.get(context).pay1 == true &&
                            FruitAppCubit.get(context).pay2 == false)
                          Row(
                            children: [
                              // Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("الدفع عند الاستلام"),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FruitAppCubit.get(context).pay2!
                          ? Colors.green[900]!
                          : Colors.grey[300]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "عنوان التوصيل",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                navigateTo(context, Address());
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 20,
                                      height: 20,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/edit.png'))),
                                  Text("تعديل"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: Image(
                                  image:
                                      AssetImage("assets/images/location.png")),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "شارع النيل، مبنى رقم ١٢٣",
                                style: TextStyle(),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildDefaultButton(
                    text: "تاكيد الطلب",
                    onPressed: () {
                      navigateTo(context, DoneOrder());
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
