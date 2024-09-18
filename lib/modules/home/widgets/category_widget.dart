import 'package:flutter/material.dart';
import 'package:news_1am/models/category_data.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryData category;
  bool isRight;
  CategoryWidget({
    required this.category,
    required this.isRight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 145,
      height: 170,
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            bottomRight: isRight ? Radius.zero : const Radius.circular(25),
            bottomLeft: isRight ? const Radius.circular(25) : Radius.zero,
            topRight: const Radius.circular(25),
            topLeft: const Radius.circular(25),
          )),
      child: Column(
        children: [
          Image.asset(
            "assets/${category.image}",
            height: 120,
          ),
          const Spacer(),
          Text(
            category.title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
