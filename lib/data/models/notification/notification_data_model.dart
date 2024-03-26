class NotificationDataModel {
  String title;
  String body;
  String sound;
  String priority;

  NotificationDataModel({
    required this.title,
    required this.body,
    required this.sound,
    required this.priority,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      title: json['title'] as String?  ?? "",
      body: json['body'] as String?  ?? "",
      sound: json['sound'] as String?  ?? "",
      priority: json['priority'] as String?  ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'sound': sound,
      'priority': priority,
    };
  }
}