import 'package:flutter/material.dart';
import 'package:sample_project/utils/project_extensions.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/styles/app_text_style.dart';

class UniversalButton extends StatelessWidget {
  const UniversalButton({super.key, required this.title, required this.onTap});
    final String title;
    final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: 16.h(), horizontal: 40.w()),
              backgroundColor: AppColors.c_1317DD,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onTap,
          child: Text(
            title,
            style: AppTextStyle.rubikMedium
                .copyWith(color: AppColors.white),
          )),
    );
  }
}
