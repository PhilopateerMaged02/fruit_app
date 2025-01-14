class CartModel {
  int id;
  String name;
  String image;
  int quantity;
  int product_id;
  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.product_id,
    required this.quantity,
  });
  CartModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? 0,
        product_id = json['product_id'] ?? 0,
        image = json['image'] ?? '',
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
}
