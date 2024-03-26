import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/screens/news/news_screen.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';
import 'package:sample_project/view_models/notification_view_model.dart';

import '../../../data/local/storage_repository.dart';
import '../../../services/local_notification_service.dart';
import '../../../utils/colors/app_colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final notificationViewModel = Provider.of<NotificationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
        actions: [


        ],
        backgroundColor: AppColors.c_1317DD,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              for (var notification in notificationViewModel.getNotifications())
                ListTile(
                  // leading: Text(notification.id.toString(), style: AppTextStyle.rubikMedium.copyWith(color: Colors.black, fontSize: 24),),
                  title: Text(notification.title,
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: Colors.black, fontSize: 18)),
                  trailing: IconButton(
                    onPressed: () {
                      LocalNotificationService()
                          .cancelNotification(notification.id);
                      context
                          .read<NotificationViewModel>()
                          .deleteNotificationById(notification.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              Visibility(
                visible: notificationViewModel.getNotifications().isNotEmpty,
                child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h(), horizontal: 40.w()),
                        backgroundColor: AppColors.c_1317DD,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      LocalNotificationService().cancelAll();
                      context
                          .read<NotificationViewModel>()
                          .deleteAllNotifications();
                    },
                    child: Center(
                        child: Text(
                      "CLEAR ALL",
                      style: AppTextStyle.rubikSemiBold
                          .copyWith(color: Colors.white),
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
