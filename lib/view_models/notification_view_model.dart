import 'package:flutter/foundation.dart';
import 'package:sample_project/data/models/notification_model.dart';

import '../data/local/storage_repository.dart';

class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel> notifications = [];
  bool isSubscribe=false;

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
    notifyListeners();
  }

  List<NotificationModel> getNotifications() {
    return notifications;

  }

  void deleteNotificationById(int id) {
    notifications.removeWhere((notification) => notification.id == id);
    notifyListeners();
  }

  void deleteAllNotifications() {
    notifications=[];
    notifyListeners();

  }

  void save(bool isSave) {
    StorageRepository.setBool(key: "subscribe", value: isSave);
    notifyListeners();
  }
  void getSave() {
    isSubscribe=StorageRepository.getBool(key: "subscribe");
    notifyListeners();
  }

}
