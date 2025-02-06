import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/cubit/cubit.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/cubit/states.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Register/cubit/states.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Register/register_screen.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/forgetPassword/forget_password_screen.dart';
import 'package:fruit_app/shared/constants.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return FruitAppLoginCubit();
      },
      child: BlocConsumer<FruitAppLoginCubit, FruitAppLoginStates>(
        listener: (BuildContext context, FruitAppLoginStates state) {},
        builder: (BuildContext context, FruitAppLoginStates state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'تسجيل دخول',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                      obscureText: FruitAppLoginCubit.get(context).visibility,
                      controller: passController,
                      decoration: InputDecoration(
                          hintText: 'كلمة المرور',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0XFFE6E9E9), width: 1)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 236, 236),
                                  width: 1.0)),
                          suffixIcon: IconButton(
                            icon: Icon(FruitAppLoginCubit.get(context).suffix),
                            onPressed: () {
                              return FruitAppLoginCubit.get(context)
                                  .changeVisibility();
                            },
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFF9FAFA),
                          filled: true),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPasswordScreen()));
                      },
                      child: const Text('نسيت كلمة المرور؟'),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Container(
                      height: 54,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          FruitAppLoginCubit.get(context).signIn(
                              context: context,
                              email: emailController.text,
                              password: passController.text);
                        },
                        child: const Text(
                          'تسجيل دخول',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لا تمتلك حساب ؟',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                          child: Text(
                            'قم بإنشاء حساب',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 150,
                          color: Colors.grey,
                        ),
                        Spacer(),
                        Text(
                          'أو',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        Spacer(),
                        Container(
                          height: 1,
                          width: 150,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        FruitAppLoginCubit.get(context)
                            .signInWithGoogle(context);
                      },
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Image(
                              image: AssetImage('assets/images/google1.jpg'),
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            const Text(
                              'تسجيل بواسطة جوجل',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Image(
                              image: AssetImage('assets/images/apple1.jpg'),
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            const Text(
                              'تسجيل بواسطة أبل',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        FruitAppLoginCubit.get(context)
                            .signInWithFacebook(context);
                      },
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Image(
                              image: AssetImage('assets/images/facebook1.jpg'),
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            const Text(
                              'تسجيل بواسطة فيسبوك',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
