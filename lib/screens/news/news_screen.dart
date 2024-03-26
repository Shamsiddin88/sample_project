import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/screens/news/add_news_screen.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/styles/app_text_style.dart';
import 'package:sample_project/view_models/news_view_model.dart';

import '../../data/api_provider/api_provider.dart';
import '../../data/local/storage_repository.dart';
import '../../services/local_notification_service.dart';
import '../../utils/colors/app_colors.dart';
import '../../view_models/notification_view_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  bool isSubscribe = false;

  @override
  Widget build(BuildContext context) {
    final notificationViewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewsScreen()));
          }, child: Text("Add", style: AppTextStyle.rubikBold.copyWith(color: Colors.white),))
        ],
        backgroundColor: AppColors.c_1317DD,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              30.getH(),
              TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h(), horizontal: 40.w()),
                    backgroundColor: AppColors.c_1317DD,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  isSubscribe = !isSubscribe; // Toggle the subscription status

                  // Update the subscription status on Firebase Messaging
                  if (isSubscribe) {
                    FirebaseMessaging.instance.subscribeToTopic("my_app_news");
                  } else {
                    FirebaseMessaging.instance.unsubscribeFromTopic("my_app_news");
                  }

                  StorageRepository.setBool(key: "subscribe", value: isSubscribe);

                  setState(() {}); // Update the UI
                },
                child: Text(
                  "Subscribe notification",
                  style: AppTextStyle.rubikBold.copyWith(
                    color: isSubscribe
                        ? Colors.white
                        : Colors.white.withOpacity(.2),
                  ),
                ),
              ),
              20.getH(),

              for (var notification in notificationViewModel.getPushNotifications())
                ListTile(
                  // leading: Text(notification.id.toString(), style: AppTextStyle.rubikMedium.copyWith(color: Colors.black, fontSize: 24),),
                  title: Text(notification.title,
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: Colors.black, fontSize: 18)),
                  subtitle: Text(notification.body,
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: Colors.black, fontSize: 18)),
                  trailing: IconButton(
                    onPressed: () {
                    context
                          .read<NewsViewModel>()
                          .deletePushNotificationById(notification.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              Visibility(
                visible: notificationViewModel.getPushNotifications().isNotEmpty,
                child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h(), horizontal: 40.w()),
                        backgroundColor: AppColors.c_1317DD,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      context
                          .read<NewsViewModel>()
                          .deletePushAllNotifications();
                    },
                    child: Center(child: Text("CLEAR ALL", style: AppTextStyle.rubikSemiBold.copyWith(color: Colors.white),))),
              )
            ],
          ),
        ),
      ),
      // Container(
      //   padding: const EdgeInsets.all(24),
      //   width: double.infinity,
      //   child:
      //   Column(
      //     children: [
      //       TextButton(
      //         onPressed: () {
      //           FirebaseMessaging.instance.subscribeToTopic("my_app_news");
      //         },
      //         child: Text(
      //           "Subscribe to topic: my_app_news",
      //           style: AppTextStyle.rubikBold.copyWith(
      //             fontSize: 24,color: Colors.black
      //           ),
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           FirebaseMessaging.instance.unsubscribeFromTopic("my_app_news");
      //         },
      //         child: Text(
      //           "Unsubscribe from topic: my_app_news",
      //           style: AppTextStyle.rubikBold.copyWith(
      //             fontSize: 24,color: Colors.black
      //           ),
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () async {
      //           String messageId = await ApiProvider().sendNotificationToUsers(
      //             fcmToken: fcmToken,
      //             title: "Bu test notification",
      //             body: "Yana test notiifcation",
      //           );
      //           debugPrint("MESSAGE ID:$messageId");
      //         },
      //         child: Text(
      //           "SEND MESSAGE TO USER",
      //           style: AppTextStyle.rubikBold.copyWith(
      //             fontSize: 24,color: Colors.black
      //           ),
      //         ),
      //       ),
      //       TextButton(
      //         onPressed: () async {
      //           String messageId = await ApiProvider().sendNotificationToUsers(
      //             topicName: "my_app_news",
      //             title: "Bu test notification",
      //             body: "Yana test notiifcation",
      //           );
      //           debugPrint("MESSAGE ID:$messageId");
      //         },
      //         child: Text(
      //           "SEND MESSAGE TO USERS",
      //           style: AppTextStyle.rubikBold.copyWith(
      //             fontSize: 24,color: Colors.black
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
