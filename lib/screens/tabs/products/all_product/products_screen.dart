import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/screens/tabs/products/product_info/product_info_screen.dart';
import 'package:sample_project/screens/tabs/products/widgets/global_product_items.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/view_models/products_view_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../data/models/product_model.dart';
import '../../../../routes.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_1317DD,
        title: Text(
          "Hamma mahsulotlar",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CategoriesViewModel>().getCategories();
              Navigator.pushNamed(context, RouteNames.addProductRoute);
            },
            icon: Icon(
              Icons.add,
              color: AppColors.white,
              size: 24.h(),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().listenProducts(),
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
                childAspectRatio: 0.80,
                children: List.generate(
                  list.length,
                  (index) {
                    ProductModel product = list[index];
                    return ZoomTapAnimation(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInfoScreen(productModel: product,)));},
                      child: GlobalProductItems(
                          imageUrl:
                              product.imageUrl,
                          name: product.productName,
                          price: product.price,
                          icon: Icons.favorite_border),
                    );
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
