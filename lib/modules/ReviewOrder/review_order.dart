import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/Address/address.dart';
import 'package:fruit_app/modules/CrediCardPayment/credit_card_payment.dart';
import 'package:fruit_app/modules/DoneOrder/done_order.dart';
import 'package:fruit_app/modules/KioskPayment/kiosk_payment.dart';
import 'package:fruit_app/modules/Payment/payment.dart';
import 'package:fruit_app/modules/TrackOrder/track_order.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class ReviewOrder extends StatelessWidget {
  String pm = "";
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
          body: SingleChildScrollView(
            child: Column(
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
                              Text(
                                  "${FruitAppCubit.get(context).finalPrice} جنيه"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("التوصيل : "),
                              Spacer(),
                              Text("30 جنيه"),
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
                                "${FruitAppCubit.get(context).finalPrice + 30} جنيه",
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
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text("**** **** **** 6522"),
                                // ),
                                if (FruitAppCubit.get(context).visa == true)
                                  InkWell(
                                    onTap: () {
                                      FruitAppCubit.get(context)
                                          .changePaymentMethodToVisa();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              FruitAppCubit.get(context).visa!
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
                                if (FruitAppCubit.get(context).mastercard ==
                                    true)
                                  InkWell(
                                    onTap: () {
                                      FruitAppCubit.get(context)
                                          .changePaymentMethodToMastercard();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: FruitAppCubit.get(context)
                                                  .mastercard!
                                              ? Colors.green[900]!
                                              : Colors.grey[300]!,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        width: 50,
                                        height: 40,
                                        //color: Colors.blue[900],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/mastercard.png")),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (FruitAppCubit.get(context).paypal == true)
                                  InkWell(
                                    onTap: () {
                                      FruitAppCubit.get(context)
                                          .changePaymentMethodToPaypal();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              FruitAppCubit.get(context).paypal!
                                                  ? Colors.green[900]!
                                                  : Colors.grey[300]!,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        width: 50,
                                        height: 40,
                                        //color: Colors.blue[900],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/paypal.png")),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (FruitAppCubit.get(context).applepay == true)
                                  InkWell(
                                    onTap: () {
                                      FruitAppCubit.get(context)
                                          .changePaymentMethodToApplepay();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: FruitAppCubit.get(context)
                                                  .applepay!
                                              ? Colors.green[900]!
                                              : Colors.grey[300]!,
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        width: 50,
                                        height: 40,
                                        color: Colors.cyan,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/images/Aman.png")),
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
                                    image: AssetImage(
                                        "assets/images/location.png")),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "${FruitAppCubit.get(context).city}" +
                                      "," +
                                      "${FruitAppCubit.get(context).address}" +
                                      "," +
                                      "${FruitAppCubit.get(context).floorApart}",
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
                        if (FruitAppCubit.get(context).pay1 == true &&
                            FruitAppCubit.get(context).pay2 == false) {
                          pm = "الدفع عند الاستلام";
                          double orderPrice =
                              FruitAppCubit.get(context).finalPrice + 30;
                          FruitAppCubit.get(context).creatOrder(
                            address: FruitAppCubit.get(context).address,
                            city: FruitAppCubit.get(context).city,
                            date: DateTime.now().toString().split(' ')[0],
                            email: FruitAppCubit.get(context).userModel!.email,
                            floorApart: FruitAppCubit.get(context).floorApart,
                            name: FruitAppCubit.get(context).userModel!.name,
                            payment_method: pm,
                            price: orderPrice.toString(),
                            quantity:
                                FruitAppCubit.get(context).cartItems.length,
                            status: "في انتظار قبول الطلب",
                          );
                          if (state is FruitAppCreateOrderLoading) {
                            Center(child: CircularProgressIndicator());
                          } else {
                            navigateTo(context, TrackOrder());
                          }
                        } else {
                          if (FruitAppCubit.get(context).visa == true ||
                              FruitAppCubit.get(context).mastercard == true) {
                            print(ApiContest.visaUrl);
                            navigateTo(context, CreditCardPayment());
                          } else if (FruitAppCubit.get(context).applepay ==
                              true) {
                            //FruitAppCubit.get(context).getRefCode();
                            navigateTo(context, KioskPayment());
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
