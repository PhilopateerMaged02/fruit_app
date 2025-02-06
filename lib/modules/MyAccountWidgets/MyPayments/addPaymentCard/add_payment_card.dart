import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyPayments/my_payments.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class AddPaymentCard extends StatelessWidget {
  var name = TextEditingController();
  var cardNumber = TextEditingController();
  var expireDate = TextEditingController();
  var cvv = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضافه بطاقه جديده",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocConsumer<FruitAppCubit, FruitAppStates>(
        listener: (BuildContext context, FruitAppStates state) {
          if (state is FruitAppAddPaymentMethodLoading) {
            Center(child: CircularProgressIndicator());
          } else if (state is FruitAppAddPaymentMethodSuccess) {
            FruitAppCubit.get(context).getPaymentCreditCardData();
            if (state is FruitAppGetPaymentCreditCardDataLoading) {
              Center(child: CircularProgressIndicator());
            } else if (state is FruitAppGetPaymentCreditCardDataSuccess) {
              showToust(
                  message: "تم اضافة البطاقة بنجاح",
                  state: ToastStates.SUCCESS);
              navigateTo(context, MyPayments());
            }
          } else if (state is FruitAppAddPaymentMethodError) {
            showToust(
                message: "حدث خطا يرجي اعادة المحاولة",
                state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, FruitAppStates state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: name,
                      text: "اسم حامل البطاقه",
                      maxChar: 1000,
                      keyboardType: TextInputType.text),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildLoginTextField(
                      controller: cardNumber,
                      text: "رقم البطاقة",
                      maxChar: 16,
                      keyboardType: TextInputType.number),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                          width: 160,
                          height: 100,
                          child: buildLoginTextField(
                              controller: expireDate,
                              text: "تاريخ الصلاحيه",
                              maxChar: 5,
                              keyboardType: TextInputType.datetime)),
                      Spacer(),
                      Container(
                          width: 160,
                          height: 100,
                          child: buildLoginTextField(
                              controller: cvv,
                              text: "cvv",
                              maxChar: 3,
                              keyboardType: TextInputType.number)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildDefaultButton(
                      text: "أضف وسيلة دفع جديده",
                      onPressed: () {
                        if (name.text.isEmpty ||
                            cardNumber.text.isEmpty ||
                            cvv.text.isEmpty ||
                            expireDate.text.isEmpty) {
                          showToust(
                              message: "من فضلك ادخل البيانات بالكامل",
                              state: ToastStates.ERROR);
                        } else {
                          bool cardExists = FruitAppCubit.get(context)
                                  .paymentCreditCardList
                                  ?.any((card) =>
                                      card.card_no == cardNumber.text.trim()) ??
                              false;
                          if (cardExists == false) {
                            FruitAppCubit.get(context).addPaymentCard(
                                name: name.text,
                                card_no: cardNumber.text,
                                cvv: cvv.text,
                                expiry_date: expireDate.text);
                          } else {
                            showToust(
                                message: "هذة البطاقة مضافة بالفعل",
                                state: ToastStates.ERROR);
                          }
                        }
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
