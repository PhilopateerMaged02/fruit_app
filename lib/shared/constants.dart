import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Color primaryColor = Colors.green.shade900;
const keyIsOnBoardingSeen = 'isOnBoardingSeen';
final supabase = Supabase.instance.client;
String? uId = '';

class ApiContest {
  //https://accept.paymob.com/api/auth/tokens
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String getAuthToken = '/auth/tokens';
  static const String paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeE9UazBOeXdpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS42by1TbjJyMzRMNzVnQ2lfYkgwaV9WSWtqZ1FiZFpDSG5GZW5oVHFTN2ZQWlVfZ0tXMnl4LW5QQWFrTHlSa2s0dGVYbDl0bXNFZmJaT1Fnc2pNa3ZpQQ==';
  static const String getOrderId = '/ecommerce/orders';
  static const String getPaymentId = '/acceptance/payment_keys';
  static const String getRefCode = '/acceptance/payments/pay';
  static String visaUrl = '';
  //https://accept.paymob.com/api/acceptance/iframes/896181?payment_token={payment_key_obtained_previously}
  static String paymentFirstToken = '';
  static String paymentOrderId = '';
  static String finalToken = '';
  static String refCode = '';

  static const String integrationIdKiosk = '4936374';
  static const String integrationIdCard = '4936045';
}
