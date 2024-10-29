import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String image;
  final String body;
  final String appName;
  final String appName2;
  final String backgroundImage;
  final MaterialButton? button;
  final bool isButton;

  OnboardingModel(
      {required this.appName,
      required this.appName2,
      this.button,
      required this.isButton,
      required this.backgroundImage,
      required this.title,
      required this.image,
      required this.body});
}
