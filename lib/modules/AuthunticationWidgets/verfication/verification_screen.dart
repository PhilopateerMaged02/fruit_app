import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class VerificationScreen extends StatelessWidget {
  var newPassController = TextEditingController();
  var repeatNewPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, state) {
        if (state is FruitAppChangePasswordSuccess) {
          navigateToandKill(context, LoginScreen());
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'التحقق من الرمز',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 29,
                ),
                Row(
                  children: [
                    Text(
                      "تغيير كلمة المرور",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    obscureText: FruitAppCubit.get(context).visibility4,
                    controller: newPassController,
                    decoration: InputDecoration(
                        hintText: 'كلمة المرور الجديده',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 236, 236),
                                width: 1.0)),
                        suffixIcon: IconButton(
                          icon: Icon(FruitAppCubit.get(context).suffix4),
                          onPressed: () {
                            FruitAppCubit.get(context).changeVisibility4();
                          },
                          color: Colors.grey,
                        ),
                        fillColor: Color(0xFFF9FAFA),
                        filled: true),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    obscureText: FruitAppCubit.get(context).visibility5,
                    controller: repeatNewPassController,
                    decoration: InputDecoration(
                        hintText: 'تأكيد كلمة المرور الجديده',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 236, 236),
                                width: 1.0)),
                        suffixIcon: IconButton(
                          icon: Icon(FruitAppCubit.get(context).suffix5),
                          onPressed: () {
                            FruitAppCubit.get(context).changeVisibility5();
                          },
                          color: Colors.grey,
                        ),
                        fillColor: Color(0xFFF9FAFA),
                        filled: true),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildDefaultButton(
                    text: "تغيير كلمة المرور",
                    onPressed: () {
                      print(FruitAppCubit.get(context).emailForForgetPass);
                      FruitAppCubit.get(context).updatePasswordForForget(
                          newPass: newPassController.text,
                          repeatNewPass: repeatNewPassController.text);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
