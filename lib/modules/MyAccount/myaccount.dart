import 'package:flutter/material.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("MyAccount screen"),
        Center(
          child: TextButton(
              onPressed: () {
                FruitAppCubit.get(context).signOutt(context);
              },
              child: Text("Sign Out")),
        ),
      ],
    );
  }
}
