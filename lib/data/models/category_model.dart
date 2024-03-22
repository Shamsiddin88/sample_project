class CategoryModel {
  final String docId;
  final String categoryName;
  final String imageUrl;

  CategoryModel({
    required this.imageUrl,
    required this.categoryName,
    required this.docId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryName: json["category_name"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "image_url": imageUrl,
      "category_name": categoryName,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "image_url": imageUrl,
      "category_name": categoryName,
    };
  }

  static CategoryModel initialValue = CategoryModel(
    docId: "",
    imageUrl: "",
    categoryName: "",
  );


  CategoryModel copyWith({
    String? docId,
    String? categoryName,
    String? imageUrl,
  }) {
    return CategoryModel(
      docId: docId ?? this.docId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  bool canAddCategoryModel() {
    if (categoryName.isEmpty) return false;
    if (imageUrl.isEmpty) return false;
    return true;
  }
}
