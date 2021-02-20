import 'package:app_for_ex/widgets/category_item.dart';
import 'package:app_for_ex/dummy_data.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      children: [
        ...DUMMY_CATEGORIES.map((e) {
          return CategoryItem(e.id, e.title, e.color);
        }).toList(),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
    );
  }
}
