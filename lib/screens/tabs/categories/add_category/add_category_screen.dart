import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/models/category_model.dart';
import 'package:sample_project/screens/widgets/universal_button.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/utilities.dart';

import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';
import '../../../../view_models/image_view_model.dart';

class AddCategoryScreen extends StatefulWidget {
  AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  CategoryModel categoryModel= CategoryModel.initialValue;

  final ImagePicker picker = ImagePicker();
  String storagePath = "";
  String imageUrl = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: AppColors.c_1317DD,title: Text("Kategoriya qo'shish",style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),),),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.getH(),
              TextField(
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
                    hintText: "Kategoriya nomini kiriting",
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
              // TextField(
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
              //       hintText: "Kategoriya rasmi URL",
              //       hintStyle: TextStyle(color: Colors.black, fontSize: 14),
              //       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(12)),
              //       disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
              //           borderRadius: BorderRadius.circular(12)),
              //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black),
              //           borderRadius: BorderRadius.circular(12))
              //   ),
              // ),
              SizedBox(height: 24.h()),
              UniversalButton(title: "Take photo", onTap: () {takeAnImage();}),

              // if (context.watch<ImageViewModel>().getLoader)
              //   const CircularProgressIndicator(),
              // if (imageUrl.isNotEmpty) Image.network(imageUrl),
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

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );
      categoryModel=categoryModel.copyWith(imageUrl: imageUrl);


      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );
      categoryModel=categoryModel.copyWith(imageUrl: imageUrl);

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h()),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h()),
            ],
          );
        });
  }
}