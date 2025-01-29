import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/ReviewOrder/review_order.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Payment extends StatelessWidget {
  var name = TextEditingController();
  var cardNumber = TextEditingController();
  var expireDate = TextEditingController();
  var cvv = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "الدفع",
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
                      backgroundColor: Colors.grey[200],
                      child: Text("4"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "المراجعه",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "أختر طريقة الدفع المناسبة : ",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "من فضلك اختر طريقه الدفع المناسبه لك.",
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        FruitAppCubit.get(context)
                            .changePaymentMethodToApplepay();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: FruitAppCubit.get(context).applepay!
                                  ? Colors.green[900]!
                                  : Colors.grey[300]!,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: 70,
                            height: 50,
                            color: Colors.cyan,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage("assets/images/Aman.png")),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FruitAppCubit.get(context)
                            .changePaymentMethodToPaypal();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: FruitAppCubit.get(context).paypal!
                                  ? Colors.green[900]!
                                  : Colors.grey[300]!,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: 70,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image:
                                      AssetImage("assets/images/paypal.png")),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FruitAppCubit.get(context)
                            .changePaymentMethodToMastercard();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: FruitAppCubit.get(context).mastercard!
                                  ? Colors.green[900]!
                                  : Colors.grey[300]!,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: 70,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/mastercard.png")),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FruitAppCubit.get(context).changePaymentMethodToVisa();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                            width: 70,
                            height: 50,
                            color: Colors.blue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage("assets/images/visa.png")),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: buildLoginTextField(
              //       controller: name, text: "اسم حامل البطاقه"),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: buildLoginTextField(
              //       controller: cardNumber, text: "رقم البطاقة"),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Container(
              //           width: 160,
              //           height: 100,
              //           child: buildLoginTextField(
              //               controller: expireDate, text: "تاريخ الصلاحيه")),
              //       Spacer(),
              //       Container(
              //           width: 160,
              //           height: 100,
              //           child:
              //               buildLoginTextField(controller: cvv, text: "cvv")),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Checkbox(
                      value: FruitAppCubit.get(context).creditCard,
                      onChanged: (value) {
                        FruitAppCubit.get(context).changeCheckBox();
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "جعل البطاقة افتراضية",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildDefaultButton(
                    text: "تأكيد & استمرار",
                    onPressed: () {
                      if (FruitAppCubit.get(context).visa == false &&
                          FruitAppCubit.get(context).mastercard == false &&
                          FruitAppCubit.get(context).paypal == false &&
                          FruitAppCubit.get(context).applepay == false) {
                        showToust(
                            message: "من فضلك اختر طريقة دفع",
                            state: ToastStates.ERROR);
                      } else if (FruitAppCubit.get(context).visa == true ||
                          FruitAppCubit.get(context).mastercard == true) {
                        FruitAppCubit.get(context).getOrderRegisterationId(
                            firstName:
                                FruitAppCubit.get(context).userModel!.name,
                            email: FruitAppCubit.get(context).userModel!.email,
                            price: FruitAppCubit.get(context)
                                .finalPrice
                                .toString());
                        navigateTo(context, ReviewOrder());
                      } else {
                        FruitAppCubit.get(context).getRefCode();
                        navigateTo(context, ReviewOrder());
                      }
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
