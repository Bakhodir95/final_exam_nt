import 'package:final_exam_nt/models/expense.dart';

abstract class ExpenseState {}

class LoadExpense extends ExpenseState {}

class AddExpense extends ExpenseState {
  final Expenses expense;
  AddExpense(this.expense);
}

class UpdateExpense extends ExpenseState {
  final Expenses expense;
  UpdateExpense(this.expense);
}

class DeleteExpense extends ExpenseState {
  final int id;
  DeleteExpense(this.id);
}
