import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news_1am/core/widgets/custom_bg.dart';
import 'package:news_1am/modules/home/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),() {
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,
              (route) => false);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomBgWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ZoomIn(
              duration: const Duration(seconds: 2),
              child: Image.asset("assets/logo.png")),
        ),
      ),
    );
  }
}
