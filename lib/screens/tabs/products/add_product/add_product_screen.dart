import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/api_provider/api_provider.dart';
import 'package:sample_project/data/models/product_model.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/utilities.dart';
import 'package:sample_project/view_models/news_view_model.dart';
import 'package:sample_project/view_models/notification_view_model.dart';
import 'package:sample_project/view_models/products_view_model.dart';

import '../../../../data/models/notification_model.dart';
import '../../../../services/local_notification_service.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  ProductModel productModel = ProductModel.initialValue;
  String? selectedValue;
  String fcmToken = "";

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().second.toInt(),
          );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.c_1317DD,
          title: Text("Mahsulot qo'shish", style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),)
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                10.getH(),
                TextField(
                  textInputAction: TextInputAction.next,
                  onChanged: (v) {
                    productModel = productModel.copyWith(productName: v);
                  },
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: 4,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Mahsulot nomini kiriting",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                          borderRadius: BorderRadius.circular(12))),
                ),
                20.getH(),
                TextField(
                  textInputAction: TextInputAction.next,
                  onChanged: (v) {
                    productModel = productModel.copyWith(productDescription: v);
                  },
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: 4,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Mahsulot tavsifini kiriting",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                          borderRadius: BorderRadius.circular(12))),
                ),
                20.getH(),
                TextField(
                  onChanged: (v) {
                    productModel =
                        productModel.copyWith(price: double.parse(v));
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: 4,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Mahsulot narxini kiriting",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                          borderRadius: BorderRadius.circular(12))),
                ),
                20.getH(),
                TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: (v) {
                    productModel = productModel.copyWith(imageUrl: v);
                  },
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: 4,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Mahsulot rasmi URL",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.black),
                          borderRadius: BorderRadius.circular(12))),
                ),
                20.getH(),
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
                                productModel = productModel.copyWith(categoryId: selectedCategory.docId); // Assuming 'id' is the property holding the categoryId

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
                    onPressed: () async {
                      if (productModel.canAddProductModel()) {
                        showSuccessMessage("SUCCESS");
                        context
                            .read<ProductsViewModel>()
                            .insertProducts(productModel, context);
                        //------------------------------LocalNotification----------------------------------
                        NotificationModel notification = NotificationModel(
                            title: "${productModel.productName} nomli mahsulot qo'shildi!",
                            id: DateTime.now().millisecond,
                            body: "Ma'lumot olishingiz mumkin"
                        );
                        context.read<NotificationViewModel>().addNotification(notification);
                        LocalNotificationService().showNotification(
                          title: notification.title,
                          body: notification.body,
                          id: notification.id,
                        );
                        //------------------------------PushNotification----------------------------------
                        context.read<NewsViewModel>().addPushNotification(notification);
                        String messageId = await ApiProvider().sendNotificationToUsers(
                          fcmToken: fcmToken,
                          title: notification.title,
                          body: "Mahsulot haqida ma'lumot olishingiz mumkin",
                        );
                        debugPrint("MESSAGE ID:$messageId");

                        Navigator.pop(context);
                      } else {
                        showErrorMessage("ERROR");
                      }
                    },
                    child: Text(
                      "Saqlash",
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: AppColors.white),
                    )),
                // TextButton(
                //   child: const Text("Show Notification"),
                //   onPressed: () {
                //     NotificationModel notification = NotificationModel(
                //       name: "Galaxy 12 nomli maxsulot qo'shildi!",
                //       id: DateTime.now().millisecond
                //     );
                //     context.read<NotificationViewModel>().addNotification(notification);
                //
                //     LocalNotificationService().showNotification(
                //       title: notification.name,
                //       body: "notification.body",
                //       id: notification.id,
                //     );
                //   },
                // ),
              ])),
        ));
  }
}
