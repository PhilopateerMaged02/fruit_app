import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Color primaryColor = Colors.green.shade900;
const keyIsOnBoardingSeen = 'isOnBoardingSeen';
final supabase = Supabase.instance.client;
String? uId = '';
