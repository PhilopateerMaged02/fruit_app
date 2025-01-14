class ProductsModel {
  int id;
  String name;
  String price;
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
      : name = json['name'] ?? '',
        id = json['id'] ?? '',
        price = json['price'] ?? '',
        image = json['image'] ?? '',
        quantity = json['quantity'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
