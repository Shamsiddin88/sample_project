class NotificationModel {
  final String title;
  final String body;
  final int id;

  NotificationModel({
    required this.title,
    required this.id,
    required this.body
  });
  static NotificationModel initialValue = NotificationModel(
    title: "",
    id: 0,
    body: "",

  );

  NotificationModel copyWith({
    String? title,
    String? body,
    int? id,

  }) {
    return NotificationModel(
      title: title ?? this.title,
      body: body ?? this.body,
      id: id ?? this.id,
       );
  }

  bool canAddNotificationModel() {
    if (title.isEmpty) return false;
    if (body.isEmpty) return false;
   return true;
  }

}
