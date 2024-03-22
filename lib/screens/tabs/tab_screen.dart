import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/screens/tabs/cart/cart_screen.dart';
import 'package:sample_project/screens/tabs/products/all_product/products_screen.dart';
import 'package:sample_project/screens/tabs/profile/profile_screen.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/images/app_images.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../view_models/tab_view_model.dart';
import 'categories/categories_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: SizedBox(
        height: 90.h(),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),

          currentIndex: context.watch<TabViewModel>().getIndex,
          onTap: (newIndex) {
            context.read<TabViewModel>().changeIndex(newIndex);
          },
          items: [
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.products,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Products",
              activeIcon: SvgPicture.asset(AppImages.products,height: 24, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.category,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Category",
              activeIcon: SvgPicture.asset(AppImages.category,height: 24, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(AppImages.cart,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Cart",
              activeIcon: SvgPicture.asset(AppImages.cart,height: 24, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.person,height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
              label: "Profile",
              activeIcon: SvgPicture.asset(AppImages.person,height: 24, colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),),
            )
          ],
        ),
      ),
    );
  }
}
