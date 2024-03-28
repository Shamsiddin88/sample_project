class CategoryModel {
  final String docId;
  final String categoryName;
  final String? imageUrl;
  final String? storagePath;

  CategoryModel(
      {this.imageUrl,
      required this.categoryName,
      required this.docId,
      this.storagePath});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      categoryName: json["category_name"] as String? ?? "",
      storagePath: json["storage_path"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "image_url": imageUrl,
      "category_name": categoryName,
      "storage_path": storagePath
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "image_url": imageUrl,
      "category_name": categoryName,
      "storage_path": storagePath,
    };
  }

  static CategoryModel initialValue = CategoryModel(
    docId: "",
    imageUrl: "",
    categoryName: "",
    storagePath: "",
  );

  CategoryModel copyWith(
      {String? docId,
      String? categoryName,
      String? imageUrl,
      String? storagePath}) {
    return CategoryModel(
      docId: docId ?? this.docId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      storagePath: storagePath ?? this.storagePath,
    );
  }

  bool canAddCategoryModel() {
    if (categoryName.isEmpty) return false;
    return true;
  }
}
