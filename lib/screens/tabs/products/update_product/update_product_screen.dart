import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/models/product_model.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';
import 'package:sample_project/view_models/products_view_model.dart';

import '../../../../data/models/notification_model.dart';
import '../../../../services/local_notification_service.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/utilities.dart';
import '../../../../view_models/category_view_model.dart';
import '../../../../view_models/notification_view_model.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key, required this.productModel});

ProductModel productModel;
  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String? selectedValue;


  @override

  Widget build(BuildContext context) {
    final TextEditingController nameController =
    TextEditingController(text: widget.productModel.productName);
    final TextEditingController descriptionController =
    TextEditingController(text: widget.productModel.productDescription);
    final TextEditingController priceController =
    TextEditingController(text: widget.productModel.price.toString());
    final TextEditingController imageUrlController =
    TextEditingController(text: widget.productModel.imageUrl);



    return Scaffold(appBar: AppBar(backgroundColor: AppColors.c_1317DD,title: Text("Mahsulotni o'zgartirish", style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),),),
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
                widget.productModel=widget.productModel.copyWith(productName: v);
              },
              decoration:
              InputDecoration(
        
                  floatingLabelBehavior:
                  FloatingLabelBehavior.always,
                  fillColor: Colors.white  ,
                  filled: true,
                  hintMaxLines: 4,
        
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  hintText: "Kitob nomini kiriting",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
                      borderRadius: BorderRadius.circular(12))
              ),
            ),
            20.getH(),
            TextField(
              controller: priceController,
              onChanged: (v){
                widget.productModel=widget.productModel.copyWith(price: double.parse(v));
              },
              textInputAction: TextInputAction.next,
              decoration:
              InputDecoration(
        
                  floatingLabelBehavior:
                  FloatingLabelBehavior.always,
                  fillColor: Colors.white  ,
                  filled: true,
                  hintMaxLines: 4,
        
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  hintText: "Mahsulot narxini kiriting",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
                      borderRadius: BorderRadius.circular(12))
              ),
            ),
            20.getH(),
            TextField(
              controller: descriptionController,
              textInputAction: TextInputAction.next,
              onChanged: (v){
                widget.productModel=widget.productModel.copyWith(productDescription: v);
              },
              decoration:
              InputDecoration(
        
                  floatingLabelBehavior:
                  FloatingLabelBehavior.always,
                  fillColor: Colors.white  ,
                  filled: true,
                  hintMaxLines: 4,
        
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  hintText: "Mahsulot tavsifi",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
                      borderRadius: BorderRadius.circular(12))
              ),
            ),

            20.getH(),
            TextField(
              controller: imageUrlController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: null,

              onChanged: (v){
                widget.productModel=widget.productModel.copyWith(imageUrl: v);
              },
              decoration:
              InputDecoration(
        
        
                  floatingLabelBehavior:
                  FloatingLabelBehavior.always,
                  fillColor: Colors.white  ,
                  filled: true,
                  hintMaxLines: 4,

        
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  hintText: "Mahsulot rasmi URL",
                  hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
                      borderRadius: BorderRadius.circular(12))
              ),
            ),
            Consumer<CategoriesViewModel>(
              builder: (context, categoriesViewModel, child) {
                final categories = categoriesViewModel.categories;
                return Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select Category',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                          final selectedCategory = categories.firstWhere((category) => category.categoryName == value);
                          widget.productModel =widget.productModel.copyWith(categoryId: selectedCategory.docId); // Assuming 'id' is the property holding the categoryId
                        });

                      },
                      items: categories
                          .map((category) => DropdownMenuItem<String>(
                        value: category.categoryName, // Assuming categoryName is the property to display
                        child: Text(
                          category.categoryName,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                );
              },
            ),
            40.getH(),
            TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h(), horizontal: 40.w()),
                    backgroundColor: AppColors.c_1317DD,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: ()async
                  {
                    if (widget.productModel.canAddProductModel()){
                      showSuccessMessage("SUCCESS");
                      context.read<ProductsViewModel>().updateProduct(widget.productModel, context);
                      NotificationModel notification = NotificationModel(
                          title: "${widget.productModel.productName} nomli mahsulot o'zgartirildi!",
                          id: DateTime.now().millisecond, body: "Ma'lumot olishingiz mumkin"
                      );
                      context.read<NotificationViewModel>().addNotification(notification);

                      LocalNotificationService().showNotification(
                        title: notification.title,
                        body: notification.body,
                        id: notification.id,
                      );

                      Navigator.pop(context);
                      setState(() {});
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
