import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/routes.dart';
import 'package:sample_project/screens/tabs/categories/update_category/update_category_screen.dart';
import 'package:sample_project/screens/tabs/products/product_category/product_category_screen.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../view_models/category_view_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_1317DD,
        title: Text(
          "Kategoriyalar",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addCategoryRoute);
            },
            icon: Icon(
              Icons.add,
              color: AppColors.white,
              size: 24.h(),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoriesViewModel>().listenCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<CategoryModel> list = snapshot.data as List<CategoryModel>;
            return ListView(
              children: [
                ...List.generate(
                  list.length,
                  (index) {
                    CategoryModel category = list[index];
                    return ZoomTapAnimation(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductCategoryScreen(
                                    categoryId: category.docId)));
                      },
                      child: ListTile(
                        leading: Image.network(
                          category.imageUrl,
                          width: 80,
                        ),
                        title: Text(category.categoryName),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: ()
                                {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                          "Kategoriya o'chirilsinmi",
                                          style: TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontSize: 18.w(),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Yo'q"),
                                              ),
                                              TextButton(
                                                onPressed: () async
                                                {
                                                  context
                                                      .read<CategoriesViewModel>()
                                                      .deleteCategory(category.docId, context);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Ha'),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                                ,
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateCategoryScreen(
                                                  categoryModel: category)));
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
