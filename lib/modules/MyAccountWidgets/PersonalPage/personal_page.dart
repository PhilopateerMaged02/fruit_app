import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/cubit/cubit.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class PersonalPage extends StatefulWidget {
  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var currentPassController = TextEditingController();

  var newPassController = TextEditingController();

  var repeatNewPassController = TextEditingController();

  bool isEnabled1 = false;

  bool isEnabled2 = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "الملف الشخصي",
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
                icon: Icon(Icons.arrow_back_ios_new_outlined)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "المعلومات الشخصية",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: buildLoginTextField(
                        controller: nameController,
                        text: FruitAppCubit.get(context).userModel!.name,
                        maxChar: 1000,
                        keyboardType: TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: buildLoginTextField(
                        controller: emailController,
                        text: FruitAppCubit.get(context).userModel!.email,
                        maxChar: 1000,
                        keyboardType: TextInputType.text),
                  ),
                  Row(
                    children: [
                      Text(
                        "تغيير كلمة المرور",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      obscureText: FruitAppCubit.get(context).visibility1,
                      controller: currentPassController,
                      decoration: InputDecoration(
                          hintText: 'كلمة المرور الحالي',
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
                            icon: Icon(FruitAppCubit.get(context).suffix1),
                            onPressed: () {
                              return FruitAppCubit.get(context)
                                  .changeVisibility1();
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
                      obscureText: FruitAppCubit.get(context).visibility2,
                      controller: newPassController,
                      decoration: InputDecoration(
                          hintText: 'كلمة المرور الجديده',
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
                            icon: Icon(FruitAppCubit.get(context).suffix2),
                            onPressed: () {
                              return FruitAppCubit.get(context)
                                  .changeVisibility2();
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
                      obscureText: FruitAppCubit.get(context).visibility3,
                      controller: repeatNewPassController,
                      decoration: InputDecoration(
                          hintText: 'تأكيد كلمة المرور الجديده',
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
                            icon: Icon(FruitAppCubit.get(context).suffix3),
                            onPressed: () {
                              return FruitAppCubit.get(context)
                                  .changeVisibility3();
                            },
                            color: Colors.grey,
                          ),
                          fillColor: Color(0xFFF9FAFA),
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  buildDefaultButton(
                      text: "تحديث البيانات",
                      onPressed: () {
                        if (nameController.text.isEmpty &&
                            emailController.text.isEmpty &&
                            currentPassController.text.isEmpty &&
                            newPassController.text.isEmpty &&
                            repeatNewPassController.text.isEmpty) {
                          showToust(
                              message: "من فضلك ادخل البيانات للتحديث",
                              state: ToastStates.ERROR);
                        } else if (currentPassController.text.isNotEmpty &&
                            newPassController.text.isNotEmpty &&
                            repeatNewPassController.text.isNotEmpty) {
                          FruitAppCubit.get(context).updatePassword(
                              currentPass: currentPassController.text.trim(),
                              newPass: newPassController.text.trim(),
                              repeatNewPass:
                                  repeatNewPassController.text.trim());
                        } else if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          FruitAppCubit.get(context).updateNameAndEmail(
                              newName: nameController.text,
                              newEmail: emailController.text);
                        } else if (nameController.text.isNotEmpty &&
                            emailController.text.isEmpty) {
                          FruitAppCubit.get(context)
                              .updateName(newName: nameController.text);
                        } else if (nameController.text.isEmpty &&
                            emailController.text.isNotEmpty) {
                          FruitAppCubit.get(context)
                              .updateEmail(newEmail: emailController.text);
                        } else if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            currentPassController.text.isNotEmpty &&
                            newPassController.text.isNotEmpty &&
                            repeatNewPassController.text.isNotEmpty) {
                          FruitAppCubit.get(context).updateNameAndEmail(
                              newName: nameController.text,
                              newEmail: emailController.text);
                          FruitAppCubit.get(context).updatePassword(
                              currentPass: currentPassController.text.trim(),
                              newPass: newPassController.text.trim(),
                              repeatNewPass:
                                  repeatNewPassController.text.trim());
                        }
                        //print(nameController.text);
                        //print(emailController.text);
                        FruitAppCubit.get(context).getUserData();
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
