import 'package:flutter/foundation.dart';

class Income {
  DateTime date;
  String title;
  num amount;

  Income({required this.date, required this.amount, required this.title});

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      date: map['date'],
      title: map['title'],
      amount: map['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'title': title,
      'amount': amount,
    };
  }
}
