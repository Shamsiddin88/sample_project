class DataModel {
  String newsImage;
  String newsTitle;
  String newsText;

  DataModel({
    required this.newsImage,
    required this.newsTitle,
    required this.newsText,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      newsImage: json['news_image'] as String?  ?? "",
      newsTitle: json['news_title'] as String?  ?? "",
      newsText: json['news_text'] as String?  ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'news_image': newsImage,
      'news_title': newsTitle,
      'news_text': newsText,
    };
  }
}