import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_project/data/api_provider/api_provider.dart';
import 'package:sample_project/utils/colors/app_colors.dart';
import 'package:sample_project/utils/project_extensions.dart';
import 'package:sample_project/utils/utilities.dart';
import 'package:sample_project/view_models/news_view_model.dart';
import '../../../../data/models/notification_model.dart';
import '../../../../services/local_notification_service.dart';
import '../../../../utils/styles/app_text_style.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  NotificationModel notificationModel = NotificationModel.initialValue;

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
            title: Text("Yangilik qo'shish", style: AppTextStyle.rubikBold.copyWith(color: AppColors.white),)
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                10.getH(),
                TextField(
                  textInputAction: TextInputAction.next,
                  onChanged: (v) {
                    notificationModel = notificationModel.copyWith(title: v);
                  },
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: 4,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Yangilik nomi",
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
                    notificationModel = notificationModel.copyWith(body: v);
                  },
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      fillColor: Colors.white,
                      filled: true,
                      hintMaxLines: null,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      hintText: "Yangilik matni",
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
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h(), horizontal: 40.w()),
                        backgroundColor: AppColors.c_1317DD,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () async {
                      if (notificationModel.canAddNotificationModel()) {
                        showSuccessMessage("SUCCESS");

                        //------------------------------LocalNotification----------------------------------
                        NotificationModel notification = NotificationModel(
                            title: notificationModel.title,
                            body: notificationModel.body,
                            id: DateTime.now().millisecond
                        );
                        // context.read<NotificationViewModel>().addNotification(notification);
                        // LocalNotificationService().showNotification(
                        //   title: notification.title,
                        //   body: notification.body,
                        //   id: notification.id,
                        // );
                        //------------------------------PushNotification----------------------------------
                        context.read<NewsViewModel>().addPushNotification(notification);
                        String messageId = await ApiProvider().sendNotificationToUsers(
                          fcmToken: fcmToken,
                          title: "Push ${notification.title}",
                          body: notification.body,
                        );
                        debugPrint("MESSAGE ID:$messageId");

                        Navigator.pop(context);
                      } else {
                        showErrorMessage("ERROR");
                      }
                    },
                    child: Text(
                      "Push user",
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: AppColors.white),
                    )),
                20.getH(),

                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h(), horizontal: 40.w()),
                        backgroundColor: AppColors.c_1317DD,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () async {
                      if (notificationModel.canAddNotificationModel()) {
                        showSuccessMessage("SUCCESS");

                        //------------------------------LocalNotification----------------------------------
                        NotificationModel notification = NotificationModel(
                            title: notificationModel.title,
                            body: notificationModel.body,
                            id: DateTime.now().millisecond
                        );
                        // context.read<NotificationViewModel>().addNotification(notification);
                        // LocalNotificationService().showNotification(
                        //   title: notification.title,
                        //   body: notification.body,
                        //   id: notification.id,
                        // );
                        //------------------------------PushNotification----------------------------------
                        context.read<NewsViewModel>().addPushNotification(notification);
                        String messageId = await ApiProvider().sendNotificationToUsers(
                          topicName: "my_app_news",
                          title: "Push ${notification.title}",
                          body: notification.body,
                        );
                        debugPrint("MESSAGE ID:$messageId");

                        Navigator.pop(context);
                      } else {
                        showErrorMessage("ERROR");
                      }
                    },
                    child: Text(
                      "Push Users",
                      style: AppTextStyle.rubikMedium
                          .copyWith(color: AppColors.white),
                    )),

              ])),
        ));
  }
}
