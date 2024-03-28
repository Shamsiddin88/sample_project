import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/models/category_model.dart';
import 'package:sample_project/screens/widgets/universal_button.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/utilities.dart';

import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';

class UpdateCategoryScreen extends StatelessWidget {
  UpdateCategoryScreen({super.key, required this.categoryModel});

  CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: categoryModel.categoryName);
    final TextEditingController imageUrlController =
    TextEditingController(text: categoryModel.imageUrl);

    return Scaffold(appBar: AppBar(backgroundColor: AppColors.c_1317DD,title: Text("Kategoriyani o'zgartirish", style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),),),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.getH(),
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                onChanged: (v){
                  categoryModel=categoryModel.copyWith(categoryName: v);
                },
                decoration:
                InputDecoration(

                    floatingLabelBehavior:
                    FloatingLabelBehavior.always,
                    fillColor: Colors.white  ,
                    filled: true,
                    hintMaxLines: 4,

                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    labelText: "Kategoriya nomini kiriting",
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
                        borderRadius: BorderRadius.circular(12))
                ),
              ),
              20.getH(),
              // TextField(
              //   controller: imageUrlController,
              //   textInputAction: TextInputAction.done,
              //   onChanged: (v){
              //     categoryModel=categoryModel.copyWith(imageUrl: v);
              //   },
              //   decoration:
              //   InputDecoration(
              //
              //
              //       floatingLabelBehavior:
              //       FloatingLabelBehavior.always,
              //       fillColor: Colors.white  ,
              //       filled: true,
              //       hintMaxLines: 4,
              //
              //       contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              //       labelText: "Mahsulot rasmi URL",
              //       labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(12)),
              //       disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(12)),
              //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
              //           borderRadius: BorderRadius.circular(12))
              //   ),
              // ),

              UniversalButton(title: "Take Photo", onTap: (){ }),
              40.getH(),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h(), horizontal: 40.w()),
                      backgroundColor: AppColors.c_1317DD,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: ()async
                  {
                    if (categoryModel.canAddCategoryModel()){
                      showSuccessMessage("SUCCESS");
                      context.read<CategoriesViewModel>().insertCategory(categoryModel,context);
                      Navigator.pop(context);

                    }
                    else {
                      showErrorMessage("ERROR");
                    }




                  },child: Text("Saqlash", style: AppTextStyle.rubikMedium.copyWith(color: AppColors.white),))


            ],

          ),
        ),
      ),);
  }
}
