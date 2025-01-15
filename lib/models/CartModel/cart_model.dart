import 'dart:ffi';

class CartModel {
  int id;
  String name;
  String image;
  int quantity;
  double price;
  int product_id;
  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.product_id,
    required this.quantity,
    required this.price,
  });
  CartModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? 0,
        product_id = json['product_id'] ?? 0,
        image = json['image'] ?? '',
        price = _parsePrice(json['price']),
        quantity = json['quantity'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'product_id': product_id,
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
