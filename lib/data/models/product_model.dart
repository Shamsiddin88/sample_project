class ProductModel {
  final String docId;
  final String productName;
  final String productDescription;
  final double price;
  final String? imageUrl;
  final String categoryId;
  final String? storagePath;

  ProductModel({
    required this.price,
    this.imageUrl,
    required this.productName,
    required this.docId,
    required this.productDescription,
    required this.categoryId,
    this.storagePath
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json["doc_id"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
      storagePath: json["storage_path"] as String? ?? "",
      categoryId: json["category_id"] as String? ?? "",
      productName: json["product_name"] as String? ?? "",
      productDescription: json["product_description"] as String? ?? "",
      price: json["price"] as double? ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "doc_id": "",
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": productDescription,
      "price": price,
      "category_id": categoryId,
      "storage_path":storagePath
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "image_url": imageUrl,
      "product_name": productName,
      "product_description": productDescription,
      "price": price,
      "category_id": categoryId,
      "storage_path":storagePath
    };
  }

  static ProductModel initialValue = ProductModel(
    docId: "",
    price: 0.0,
    imageUrl: "",
    productName: "",
    productDescription: "",
    categoryId: "",
    storagePath: ""
  );


  ProductModel copyWith({
    String? docId,
    String? productName,
    String? productDescription,
    double? price,
    String? imageUrl,
    String? categoryId,
    String? storagePath
    }) {
    return ProductModel(
      docId: docId ?? this.docId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      storagePath: storagePath ?? this.storagePath
    );
  }

  bool canAddProductModel() {
    if (productName.isEmpty) return false;
    if (productDescription.isEmpty) return false;
    if (price == 0.0) return false;
    if (categoryId.isEmpty) return false;
    return true;
  }

}
