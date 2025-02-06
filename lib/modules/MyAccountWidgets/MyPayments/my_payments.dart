import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyPayments/addPaymentCard/add_payment_card.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class MyPayments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المدفوعات",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mode_edit_outline_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocConsumer<FruitAppCubit, FruitAppStates>(
        listener: (BuildContext context, FruitAppStates state) {},
        builder: (BuildContext context, FruitAppStates state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (FruitAppCubit.get(context).paymentCreditCardList.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildCreditCardItem(
                          FruitAppCubit.get(context)
                              .paymentCreditCardList[index]),
                      separatorBuilder: (context, index) => Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      itemCount: FruitAppCubit.get(context)
                          .paymentCreditCardList
                          .length,
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Icon(Icons.credit_card_off,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "لا يوجد لديك بطاقات دفع مضافة",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildDefaultButton(
                    text: "أضف وسيلة دفع جديده",
                    onPressed: () {
                      navigateTo(context, AddPaymentCard());
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
