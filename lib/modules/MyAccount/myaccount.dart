import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';
import 'package:fruit_app/shared/cubit/states.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FruitAppCubit, FruitAppStates>(
      listener: (BuildContext context, FruitAppStates state) {},
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
                            onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                        onTap: () {},
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
                      FruitAppCubit.get(context).signOutt(context);
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
