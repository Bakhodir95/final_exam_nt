import 'package:final_exam_nt/bloc/expense_event.dart';
import 'package:final_exam_nt/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpanseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final DatabaseHelper databaseHelper;

  ExpanseBloc(this.databaseHelper) : super(ExpanseLoas()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasksData = await databaseHelper.getTasks();
        final tasks = tasksData.map((task) => Task.fromMap(task)).toList();
        emit(TaskLoaded(tasks));
      } catch (_) {
        emit(TaskError());
      }
    });

    on<AddExpense>((event, emit) async {
      try {
        await databaseHelper.insertTask(event.task.toMap());
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        await databaseHelper.updateTask(event.task.toMap());
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await databaseHelper.deleteTask(event.id);
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });
  }
}
