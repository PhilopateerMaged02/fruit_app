import 'dart:ffi';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_app/shared/cubit/cubit.dart';

class OrdersModel {
  int id;
  String name;
  String email;
  int quantity;
  String price;
  String address;
  String city;
  String floorApart;
  String payment_method;
  String status;
  String date;
  OrdersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.date,
    required this.floorApart,
    required this.payment_method,
    required this.status,
    required this.quantity,
    required this.price,
  });
  OrdersModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        id = json['id'] ?? 0,
        email = json['email'] ?? '',
        price = json['price'] ?? '',
        address = json['address'] ?? '',
        city = json['city'] ?? '',
        date = json['date'] ?? '',
        floorApart = json['floorApart'] ?? '',
        payment_method = json['payment_method'] ?? '',
        status = json['status'] ?? '',
        quantity = json['quantity'] ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'address': address,
      'email': email,
      'quantity': quantity,
      'city': city,
      'date': date,
      'floorApart': floorApart,
      'status': status,
      'payment_method': payment_method,
      'price': price,
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
