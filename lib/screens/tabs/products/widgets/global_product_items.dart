import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample_project/utils/images/app_images.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';


class GlobalProductItems extends StatelessWidget {
  const GlobalProductItems(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.icon});

  final String imageUrl;
  final String name;
  final double price;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w(), vertical: 6.h()),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFb8c0ff).withOpacity(0.4),
              const Color(0xFFbbd0ff).withOpacity(0.4),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [1.0, 1.0],
            tileMode: TileMode.clamp,
          ),

      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.h()),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imageUrl,
                        width: 150.w(),
                        height: 120.h(),
                        fit: BoxFit.cover,
                      )),
                ),

              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: AppTextStyle.rubikBold.copyWith(color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  10.getH(),
                  Text("${price.toString()} so'm",
                      style:
                          AppTextStyle.rubikBold.copyWith(color: AppColors.c_1317DD), textAlign: TextAlign.center,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
