import 'package:flutter/foundation.dart';
import 'package:sample_project/data/models/notification_model.dart';

class NewsViewModel extends ChangeNotifier {
  List<NotificationModel> pushNotifications = [];

  void addPushNotification(NotificationModel notification) {
    pushNotifications.add(notification);
    notifyListeners();
  }

  List<NotificationModel> getPushNotifications() {
    return pushNotifications;

  }

  void deletePushNotificationById(int id) {
    pushNotifications.removeWhere((notification) => notification.id == id);
    notifyListeners();
  }

  void deletePushAllNotifications() {
    pushNotifications=[];
    notifyListeners();

  }


}
