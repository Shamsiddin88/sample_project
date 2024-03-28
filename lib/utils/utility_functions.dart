import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';

import '../view_models/image_view_model.dart';

showSnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTextStyle.rubikSemiBold
            .copyWith(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

showErrorForRegister(
  String code,
  BuildContext context,
) {
  if (code == 'weak-password') {
    debugPrint('The password provided is too weak.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Passwordni xato kiritdingiz",
    );
  } else if (code == 'email-already-in-use') {
    debugPrint('The account already exists for that email.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Bu e-pochta uchun hisob allaqachon mavjud.",
    );
  }
}

showErrorForLogin(
  String code,
  BuildContext context,
) {
  if (code == 'wrong-password') {
    debugPrint('The password provided is wrong.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Passwordni xato kiritdingiz",
    );
  } else if (code == 'invalid-email') {
    debugPrint('The e-mail is invalid.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Bu e-pochta yaqroqsiz.",
    );
  } else if (code == 'user-disabled') {
    debugPrint('The user is blocked.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Foydalanuvchi bloklangan.",
    );
  } else {
    debugPrint('The user is not found.');
    if (!context.mounted) return;
    showSnackbar(
      context: context,
      message: "Foydalanuvchi topilmadi.",
    );
  }


}
//
// Future <String> _getImageFromCamera(BuildContext context) async {
//   final ImagePicker picker = ImagePicker();
//   String storagePath = "";
//   String imageUrl = "";
//   XFile? image = await picker.pickImage(
//     source: ImageSource.camera,
//     maxHeight: 1024,
//     maxWidth: 1024,
//   );
//   if (image != null && context.mounted) {
//     debugPrint("IMAGE PATH:${image.path}");
//     storagePath = "files/images/${image.name}";
//     imageUrl = await context.read<ImageViewModel>().uploadImage(
//       pickedFile: image,
//       storagePath: storagePath,
//     );
//     // categoryModel=categoryModel.copyWith(imageUrl: imageUrl);
//
//
//     debugPrint("DOWNLOAD URL:$imageUrl");
//   }
//   debugPrint("imageURL: ${imageUrl}");
//   return imageUrl;
// }
//
// Future <String> _getImageFromGallery(BuildContext context) async {
//   XFile? image = await picker.pickImage(
//     source: ImageSource.gallery,
//     maxHeight: 1024,
//     maxWidth: 1024,
//   );
//   if (image != null && context.mounted) {
//     debugPrint("IMAGE PATH:${image.path}");
//     storagePath = "files/images/${image.name}";
//     imageUrl = await context.read<ImageViewModel>().uploadImage(
//       pickedFile: image,
//       storagePath: storagePath,
//     );
//     // categoryModel=categoryModel.copyWith(imageUrl: imageUrl);
//
//     debugPrint("DOWNLOAD URL:$imageUrl");
//   }
//   debugPrint("imageURL: ${imageUrl}");
//   return imageUrl;
// }
//
// void takeAnImage(BuildContext context) {
//   showModalBottomSheet(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//           )),
//       context: context,
//       builder: (context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 12.h()),
//             ListTile(
//               onTap: () async {
//                 imageUrl = await _getImageFromGallery(context);
//                 Navigator.pop(context);
//               },
//               leading: const Icon(Icons.photo_album_outlined),
//               title: const Text("Gallereyadan olish"),
//             ),
//             ListTile(
//               onTap: () async {
//                 imageUrl = await _getImageFromCamera(context);
//                 Navigator.pop(context);
//               },
//               leading: const Icon(Icons.camera_alt),
//               title: const Text("Kameradan olish"),
//             ),
//             SizedBox(height: 24.h()),
//           ],
//         );
//       });
// }
