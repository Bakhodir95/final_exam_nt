import 'package:flutter/foundation.dart';

class Expenses {
  String category;
  DateTime date;
  String comment;
  num amount;

  Expenses({
    required this.date,
    required this.comment,
    required this.category,
    required this.amount,
  });

  factory Expenses.fromMap(Map<String, dynamic> map) {
    return Expenses(
      date: map['date'],
      amount: map['amount'],
      comment: map['comment'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'comment': comment,
      'amount': amount,
      'category': category,
    };
  }
}
