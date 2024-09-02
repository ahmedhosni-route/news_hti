import 'package:flutter/material.dart';

import '../../../models/category_data.dart';
import '../widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  void Function(CategoryData) onTap;
  CategoryScreen({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Pick your category\nof interest",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: CategoryData.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 140 / 160,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTap(CategoryData.categories[index]);
                  },
                  child: CategoryWidget(
                    category: CategoryData.categories[index],
                    isRight: index % 2 == 0,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
