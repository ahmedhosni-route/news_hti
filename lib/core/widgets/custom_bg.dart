import 'package:flutter/material.dart';

class CustomBgWidget extends StatelessWidget {
  final Widget child;
  const CustomBgWidget({required this.child , super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/pattern.png"),
        ),
      ),
      child:child ,
    );
  }
}
