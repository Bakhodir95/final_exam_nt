import 'package:final_exam_nt/models/expense.dart';

abstract class ExpenseEvent {}

class LoadExpense extends ExpenseEvent {}

class AddExpense extends ExpenseEvent {
  final Expenses expense;
  AddExpense(this.expense);
}

class UpdateExpense extends ExpenseEvent {
  final Expenses expense;
  UpdateExpense(this.expense);
}

class DeleteExpense extends ExpenseEvent {
  final int id;
  DeleteExpense(this.id);
}
