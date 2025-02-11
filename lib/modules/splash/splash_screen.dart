import 'package:flutter/material.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/modules/onBoarding/onBoarding_screen.dart';
import 'package:fruit_app/shared/components.dart';
import 'package:fruit_app/shared/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animateTopImage = false;
  bool animateMiddleImage = false;
  bool animateBottomImage = false;

  @override
  void initState() {
    super.initState();
    executeSplashScreen();
    startAnimations();
  }

  void startAnimations() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() => animateTopImage = true);
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() => animateMiddleImage = true);
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() => animateBottomImage = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeOut,
            top: animateTopImage ? 0 : -100,
            left: 0,
            child: Image(image: AssetImage("assets/images/plant.jpg")),
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 3),
              opacity: animateMiddleImage ? 1.0 : 0.0,
              child: Container(
                width: 250,
                height: 250,
                child: Image(image: AssetImage("assets/images/Logo.png")),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.easeOut,
            bottom: animateBottomImage ? 0 : -100,
            left: 0,
            right: 0,
            child: Image(
              image: AssetImage("assets/images/bubbles.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  void executeSplashScreen() {
    bool key = SharedPrefrencesSingleton.getBool(keyIsOnBoardingSeen);
    Future.delayed(const Duration(seconds: 5), () {
      if (key != false && uId == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      } else if (key != false && uId != null) {
        navigateToandKill(context, FruitappLayout());
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
