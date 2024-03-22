import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/screens/tabs/products/widgets/global_product_items.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/view_models/products_view_model.dart';

import '../../../../data/models/product_model.dart';
import '../../../../routes.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key, required this.categoryId});

  final String categoryId;
  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsViewModel>(context);
    product.getProductsByCategory(widget.categoryId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_1317DD,
        title: Text(
          "Hamma mahsulotlar",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
       
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().getProductsByCategory(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data as List<ProductModel>;
            return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                children: List.generate(
                  list.length,
                      (index) {
                    ProductModel product = list[index];
                    return GlobalProductItems(
                        imageUrl:
                        product.imageUrl,
                        name: product.productName,
                        price: product.price,
                        onTap: () {},
                        likeOnTap: () {},
                        icon: Icons.favorite_border);
                  },
                ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
