class FavouritesModel {
  int id;
  int product_id;

  FavouritesModel({
    required this.id,
    required this.product_id,
  });

  FavouritesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        product_id = json['product_id'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': product_id,
    };
  }
}
