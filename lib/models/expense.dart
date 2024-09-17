import 'package:flutter/foundation.dart';

class Expenses {
  DateTime date;
  String title;
  num amount;

  Expenses({required this.date, required this.amount, required this.title});
}

factory Expenses.fromMAp(Map<String,dynamic> map); 