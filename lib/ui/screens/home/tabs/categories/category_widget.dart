import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;

  const CategoryWidget({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: categoryDM.isLeftSided ? Radius.zero : const Radius.circular(16),
          bottomRight: !categoryDM.isLeftSided ? Radius.zero : const Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                categoryDM.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            categoryDM.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
