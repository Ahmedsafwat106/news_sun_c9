import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;

  const CategoryWidget({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: categoryDM.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomLeft: categoryDM.isLeftSided ? Radius.zero : Radius.circular(16),
          bottomRight: !categoryDM.isLeftSided ? Radius.zero : Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Image.asset(categoryDM.imagePath),
          Text(categoryDM.title),
        ],
      ),
    );
  }
}
