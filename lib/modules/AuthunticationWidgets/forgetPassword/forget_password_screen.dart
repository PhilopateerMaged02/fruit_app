import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/verfication/verification_screen.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'نسيان كلمة المرور',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'لا تقلق ، ما عليك سوى كتابة بريدك الالكتروني وسنرسل رمز التحقق.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(
                  height: 31,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'البريد الالكتروني',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFFE6E9E9), width: 1)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0XFFE6E9E9),
                        width: .2,
                      ),
                    ),
                    fillColor: Color(0xFFF9FAFA),
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 54,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // FruitAppCubit.get(context)
                      //     .resetPasswordViaEmail(email: phoneController.text);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => VerificationScreen()));
                      FruitAppCubit.get(context).sendPasswordResetEmail(
                          context, emailController.text.trim());
                      print(FruitAppCubit.get(context)
                          .emailForForgetPass
                          .toString());
                    },
                    child: const Text(
                      'نسيت كلمة المرور',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
