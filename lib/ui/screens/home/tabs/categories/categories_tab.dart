import 'package:flutter/material.dart';
import 'package:news_sun_c9/data/model/category_dm.dart';
import 'package:news_sun_c9/ui/screens/home/tabs/categories/category_widget.dart';

class CategoriesTab extends StatelessWidget {
  final void Function(CategoryDM) onCategoryClick;
  const CategoriesTab({super.key,required this.onCategoryClick,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pick your category"),
        Expanded(
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  onCategoryClick(categories[index]);
                },
                  child: CategoryWidget(categoryDM: categories[index]));
            },
          ),
        ),
      ],
    );
  }
}
