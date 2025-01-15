class ProductsModel {
  int id;
  String name;
  double price; // Use Dart's `double` type
  String image;
  int quantity;

  ProductsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  ProductsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        price = _parsePrice(json['price']),
        image = json['image'] ?? '',
        quantity = json['quantity'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  static double _parsePrice(dynamic price) {
    if (price == null) {
      return 0.0; // Default value for null
    } else if (price is int) {
      return price.toDouble(); // Convert int to double
    } else if (price is double) {
      return price; // Already a double
    } else if (price is String) {
      // Try parsing String to double
      return double.tryParse(price) ?? 0.0;
    } else {
      // Handle unexpected types
      throw FormatException('Invalid price type: ${price.runtimeType}');
    }
  }
}
