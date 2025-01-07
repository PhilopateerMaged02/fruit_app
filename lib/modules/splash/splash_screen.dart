import 'package:flutter/material.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/Login/login_screen.dart';
import 'package:fruit_app/modules/onBoarding/onBoarding_screen.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    executeSpalshScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(image: AssetImage("assets/images/plant.jpg")),
              ],
            ),
            //Spacer(),
            Image(image: AssetImage("assets/images/fruithub.jpg")),
            //Spacer(),
            Image(
              image: AssetImage("assets/images/bubbles.jpg"),
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

  void executeSpalshScreen() {
    bool key = SharedPrefrencesSingleton.getBool(keyIsOnBoardingSeen);
    Future.delayed(const Duration(seconds: 3), () {
      if (key != false && uId == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      } else if (key != false && uId != null) {
        navigateTo(context, FruitappLayout());
      } else if (key == false && uId == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (route) => false,
        );
      }
    });
  }
}
