import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_app/Service/shared_pref.dart';
import 'package:fruit_app/layouts/fruitapp_layout.dart';
import 'package:fruit_app/models/onBoarding/onBoarding_model.dart';
import 'package:fruit_app/modules/AuthunticationWidgets/Login/login_screen.dart';
import 'package:fruit_app/shared/constants.dart';

List<OnboardingModel> list = [
  OnboardingModel(
      title: "مرحبا بك في ",
      appName: "Fruit",
      backgroundImage: "assets/images/Vector.svg",
      appName2: "HUB",
      isButton: false,
      image: "assets/images/onBoarding1.svg",
      body:
          "اكتشف تجربة تسوق فريدة مع FruitHUB. استكشف مجموعتنا الواسعة من الفواكه الطازجة الممتازة واحصل على أفضل العروض والجودة العالية."),
  OnboardingModel(
      title: "ابحث وتسوق",
      backgroundImage: "assets/images/Vector2.svg",
      appName: "",
      appName2: "",
      isButton: true,
      image: "assets/images/onBoarding2.svg",
      body:
          "نقدم لك أفضل الفواكه المختارة بعناية. اطلع على التفاصيل والصور والتقييمات لتتأكد من اختيار الفاكهة المثالية"),
];

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

var currentPage = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageView.builder(
        itemBuilder: (context, index) => buildOnBoardingItem(list[index]),
        itemCount: 2,
      ),
    ));
  }

  Widget buildOnBoardingItem(OnboardingModel model) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Stack(
            //alignment: AlignmentDirectional.bottomCenter,
            children: [
              Positioned.fill(
                  child: SvgPicture.asset(
                '${model.backgroundImage}',
                fit: BoxFit.fill,
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  '${model.image}',
                  //fit: BoxFit.fill,
                ),
              ),
              if (model.isButton == false)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () {
                      SharedPrefrencesSingleton.setBool(
                          keyIsOnBoardingSeen, true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'تخط',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 64,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${model.title}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model.appName2}',
              style: TextStyle(fontSize: 24, color: Colors.orange),
            ),
            Text(
              '${model.appName}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${model.body}',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        if (model.isButton == false)
          DotsIndicator(
            dotsCount: 2,
            decorator: DotsDecorator(
              activeColor: primaryColor,
              color: primaryColor.withOpacity(.5),
            ),
          ),
        if (model.isButton)
          DotsIndicator(
            dotsCount: 2,
            decorator: DotsDecorator(
              activeColor: primaryColor,
              color: primaryColor,
            ),
          ),
        if (model.isButton == true)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    SharedPrefrencesSingleton.setBool(
                        keyIsOnBoardingSeen, true);
                    if (uId == null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FruitappLayout()),
                        (route) => false,
                      );
                    }
                  },
                  child: Text(
                    'ابدأ الان',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
      ],
    );
  }
}
