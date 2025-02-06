import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyFavourites/my_favourites.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyOrders/my_orders.dart';
import 'package:fruit_app/modules/MyAccountWidgets/MyPayments/my_payments.dart';
import 'package:fruit_app/modules/MyAccountWidgets/PersonalPage/personal_page.dart';
import 'package:fruit_app/modules/MyAccountWidgets/WhoAreWe/who_are_we.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {
        if (state is FruitAppUploadImageSuccess) {
          FruitAppCubit.get(context).getUserData();
        } else if (state is FruitAppUploadImageError) {
          showToust(
              message: "حدث خطا يرجي اعادة المحاولة", state: ToastStates.ERROR);
        }
      },
      builder: (BuildContext context, FruitAppStates state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Container(),
            title: Text(
              "حسابي",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is FruitAppUploadImageLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                  Row(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(sqrt(0), 1.5),
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(FruitAppCubit.get(
                                        context)
                                    .userModel
                                    ?.profile_image ??
                                "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                          ),
                          InkWell(
                            onTap: () async {
                              FruitAppCubit.get(context).getProfileImage();
                            },
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage("assets/images/camera.png"),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FruitAppCubit.get(context).userModel?.name ??
                                  "Guest",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                            Text(
                              FruitAppCubit.get(context).userModel?.email ??
                                  "mail@mail.com",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "عام",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, PersonalPage());
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image:
                                        AssetImage("assets/images/user.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "الملف الشخصي",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, MyOrders());
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image:
                                        AssetImage("assets/images/box.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "طلباتي",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, MyPayments());
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/emptyWallet.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "المدفوعات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          FruitAppCubit.get(context).getFavouritesData();
                          navigateTo(context, MyFavourites());
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image:
                                        AssetImage("assets/images/heart.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "المفضلة",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image:
                                        AssetImage("assets/images/noti.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "الاشعارات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Container(
                                width: 8,
                                height: 8,
                                child:
                                    Switch(value: true, onChanged: (value) {}),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/global.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "اللغة",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Text("العربية"),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/magicpen.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "الوضع",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Container(
                                width: 8,
                                height: 8,
                                child:
                                    Switch(value: false, onChanged: (value) {}),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "المساعدة",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, WhoAreWe());
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/infoCircle.png"))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "من نحن",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.grey[500]),
                            ),
                            Spacer(),
                            Container(
                                width: 25,
                                height: 25,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/arrowRight.png"))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'هل ترغب في تسجيل الخروج ؟',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Handle "Yes" action
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  print('Yes button pressed');
                                },
                                child: buildDefaultButton(
                                    text: "تأكيد",
                                    onPressed: () {
                                      FruitAppCubit.get(context)
                                          .signOutt(context);
                                    }),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Handle "No" action
                                },
                                child: Container(
                                  height: 54,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: primaryColor, width: 2)),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      print('No button pressed');
                                    },
                                    child: Text(
                                      "لا ارغب",
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            actionsAlignment: MainAxisAlignment.start,
                          );
                        },
                      );
                    },
                    child: Container(
                      color: Colors.green[50],
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(color: Colors.green[800]),
                              ),
                            ),
                          ),
                          Container(
                              width: 20,
                              height: 20,
                              child: Image(
                                  image: AssetImage("assets/images/exit.png")))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
