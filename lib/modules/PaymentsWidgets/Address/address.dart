import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/PaymentsWidgets/Payment/payment.dart';
import 'package:fruit_app/modules/PaymentsWidgets/ReviewOrder/review_order.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class Address extends StatelessWidget {
  var address = TextEditingController();
  var city = TextEditingController();
  var floorApart = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "العنوان",
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
                  child: buildLoginTextField(
                      controller: name,
                      text: FruitAppCubit.get(context).userModel!.name,
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: email,
                      text: FruitAppCubit.get(context).userModel!.email,
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: address,
                      text: "العنوان",
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: city,
                      text: "المدينه",
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: floorApart,
                      text: "رقم الطابق , رقم الشقه ..",
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Switch(
                          value: FruitAppCubit.get(context).saveAddress!,
                          onChanged: (value) {
                            FruitAppCubit.get(context).changeSaveAddress();
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "حفظ العنوان",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildDefaultButton(
                      text: "التالي",
                      onPressed: () {
                        if (address.text.isEmpty ||
                            city.text.isEmpty ||
                            floorApart.text.isEmpty) {
                          showToust(
                              message: "من فضلك اكمل البيانات",
                              state: ToastStates.ERROR);
                        } else {
                          FruitAppCubit.get(context).address = address.text;
                          FruitAppCubit.get(context).city = city.text;
                          FruitAppCubit.get(context).floorApart =
                              floorApart.text;
                          if (FruitAppCubit.get(context).pay1 == true) {
                            navigateTo(context, ReviewOrder());
                            print(FruitAppCubit.get(context).address);
                            print(FruitAppCubit.get(context).city);
                            print(FruitAppCubit.get(context).floorApart);
                          } else {
                            print(FruitAppCubit.get(context).address);
                            print(FruitAppCubit.get(context).city);
                            print(FruitAppCubit.get(context).floorApart);
                            navigateTo(context, Payment());
                          }
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
