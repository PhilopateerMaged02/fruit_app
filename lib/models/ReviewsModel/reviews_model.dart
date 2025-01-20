class ReviewsModel {
  int id;
  String name;
  int product_id; // Use Dart's `double` type
  String image;
  int rate;
  String comment;
  String time;
  String uId;

  ReviewsModel({
    required this.id,
    required this.name,
    required this.comment,
    required this.image,
    required this.time,
    required this.product_id,
    required this.rate,
    required this.uId,
  });

  ReviewsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        uId = json['uId'] ?? '',
        image = json['image'] ?? '',
        product_id = json['product_id'] ?? 0,
        comment = json['comment'] ?? '',
        time = json['time'] ?? '',
        rate = json['rate'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'comment': comment,
      'time': time,
      'product_id': product_id,
      'rate': rate,
      'uId': uId,
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
