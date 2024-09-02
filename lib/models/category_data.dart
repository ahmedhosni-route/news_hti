// business entertainment general health science sports technology

import 'package:flutter/material.dart';

class CategoryData {
  String id;
  String title;
  String image;
  Color color;
  CategoryData({
    required this.id,
    required this.title,
    required this.image,
    required this.color,
  });
 static List<CategoryData> categories = [
    CategoryData(id: "business",
        title: "Business",
        image: "bussines.png", color: Colors.blue),
    CategoryData(id: "entertainment",
        title: "Entertainment",
        image: "environment.png", color: Colors.red),
    CategoryData(id: "general",
        title: "General",
        image: "Politics.png", color: Colors.amber),
    CategoryData(id: "health",
        title: "Health",
        image: "health.png", color: Colors.indigo),
    CategoryData(id: "sports",
        title: "Sports",
        image: "ball.png", color: Colors.green),
    CategoryData(id: "science",
        title: "Science",
        image: "science.png", color: Colors.orange),
  ];
}
