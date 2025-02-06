import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';
import 'package:path/path.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<bool> isExpandedList = List.generate(100, (index) => false);

  void toggleExpansion(int index) {
    setState(() {
      isExpandedList[index] = !isExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "طلباتي",
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
        listener: (BuildContext context, FruitAppStates state) {},
        builder: (BuildContext context, FruitAppStates state) {
          var cubit = FruitAppCubit.get(context);
          if (cubit.ordersList.isEmpty) {
            return Center(child: Text("لا توجد طلبات حتى الآن"));
          }
          if (isExpandedList.length != cubit.ordersList.length) {
            isExpandedList =
                List.generate(cubit.ordersList.length, (index) => false);
          }
          return ListView.builder(
            itemCount: cubit.ordersList.length,
            itemBuilder: (context, index) {
              return buildOrderItem(
                isExpanded: isExpandedList[index],
                toggleExpansion: () => toggleExpansion(index),
                orderModel: cubit.ordersList[index],
              );
            },
          );
        },
      ),
    );
  }
}
