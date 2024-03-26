import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/models/product_model.dart';
import 'package:sample_project/screens/tabs/products/update_product/update_product_screen.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/view_models/products_view_model.dart';

import '../../../../data/models/notification_model.dart';
import '../../../../services/local_notification_service.dart';
import '../../../../utils/styles/app_text_style.dart';
import '../../../../view_models/category_view_model.dart';
import '../../../../view_models/notification_view_model.dart';

class ProductInfoScreen extends StatefulWidget {
  const ProductInfoScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.c_1317DD,
          title: Center(
              child: Text(
            "Mahsulot ma'lumotlari",
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w(), vertical: 10.h()),
                            child: SizedBox(
                                height: 200.h(),
                                width: 150.w(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.w()),
                                  child: Image.network(
                                    widget.productModel.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h()),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h(),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w()),
                                    child: Text("Mahsulot nomi", maxLines: null, style: AppTextStyle.rubikBold.copyWith(color: AppColors.c_1317DD, fontSize: 20),),
                                  ),
                                  SizedBox(
                                    height: 5.h(),
                                  ),
                                  Container(
                                    width: 160,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10.w()),
                                      child: Text(
                                        widget.productModel.productName,
                                        maxLines: null,
                                        style: AppTextStyle.rubikBold.copyWith(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h(),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w()),
                                    child: const Text("Narxi"),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w()),
                                    child: Row(
                                      children: [

                                        Text(
                                          widget.productModel.price.toString(),
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.black),
                                        ),
                                        Text(
                                          " so'm",
                                          style: TextStyle(
                                              fontSize: 19, color: AppColors.c_1317DD),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h(),
                      ),
                      const Text(
                        "Mahsulot haqida",
                      ),
                      SizedBox(
                        height: 10.h(),
                      ),
                      Text(widget.productModel.productDescription,
                          style: AppTextStyle.rubikSemiBold
                              .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: ()
                    {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              "Mahsulot o'chirilsinmi",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 18.w(),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yo'q"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      context
                                          .read<ProductsViewModel>()
                                          .deleteProduct(
                                              widget.productModel.docId,
                                              context);
                                      NotificationModel notification = NotificationModel(
                                          title: "${widget.productModel.productName} nomli mahsulot o'chirildi!",
                                          id: DateTime.now().millisecond, body: "Ma'lumot olishingiz mumkin"
                                      );
                                      context.read<NotificationViewModel>().addNotification(notification);

                                      LocalNotificationService().showNotification(
                                        title: notification.title,
                                        body: notification.body,
                                        id: notification.id,
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ha'),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(10.w()),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w(), vertical: 10.h()),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w()),
                        color: AppColors.c_1317DD,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            " O'chirish",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 20.w(),),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      context.read<CategoriesViewModel>().getCategories();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateProductScreen(
                                  productModel: widget.productModel)));
                    },
                    borderRadius: BorderRadius.circular(10.w()),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w(), vertical: 10.h()),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w()),
                        color: AppColors.c_1317DD,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                          Text(
                            " O'zgartrish",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
