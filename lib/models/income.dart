import 'package:flutter/foundation.dart';

class Income {
  DateTime date;
  String title;
  num amount;

  Income({required this.date, required this.amount, required this.title});
}


// factory Income.fromMAp(Map<String,dynamic> map); 