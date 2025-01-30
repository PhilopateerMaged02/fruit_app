import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/Address/address.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Shipping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "الشحن",
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
                        backgroundColor: Colors.grey[200],
                        child: Text("2"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "العنوان",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey[200],
                        child: Text("3"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "الدفع",
                          style: TextStyle(color: Colors.grey),
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: FruitAppCubit.get(context).pay1!
                            ? Colors.green[900]!
                            : Colors.grey[300]!,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Row(
                        children: [
                          Radio(
                              value: FruitAppCubit.get(context).pay1,
                              groupValue: true,
                              onChanged: (value) {
                                FruitAppCubit.get(context).changeRadioPay1();
                              }),
                          Column(
                            children: [
                              Text(
                                "الدفع عند الاستلام",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("التسليم من المكان"),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "${FruitAppCubit.get(context).finalPrice} جنية",
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w700),
                          )
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Row(
                        children: [
                          Radio(
                              value: FruitAppCubit.get(context).pay2,
                              groupValue: true,
                              onChanged: (value) {
                                FruitAppCubit.get(context).changeRadioPay2();
                              }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ادفع الان باستخدام ...",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              Text("يرجي تحديد طريقه الدفع"),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "${FruitAppCubit.get(context).finalPrice} جنية",
                            style: TextStyle(
                                color: Colors.green[900],
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: buildDefaultButton(
                      text: "التالي",
                      onPressed: () {
                        if (FruitAppCubit.get(context).pay1 == false &&
                            FruitAppCubit.get(context).pay2 == false) {
                          showToust(
                              message: "من فضلك اختر طريقة دفع",
                              state: ToastStates.ERROR);
                        } else {
                          navigateTo(context, Address());
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
