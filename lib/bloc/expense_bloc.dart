
// import 'package:flutter/material.dart';

// class TaskBloc extends BlockSemantics<TaskEvent, TaskState> {
//   final DatabaseHelper databaseHelper;

//   TaskBloc(this.databaseHelper) : super(TaskLoading()) {
//     on<LoadTasks>((event, emit) async {
//       emit(TaskLoading());
//       try {
//         final tasksData = await databaseHelper.getTasks();
//         final tasks = tasksData.map((task) => Task.fromMap(task)).toList();
//         emit(TaskLoaded(tasks));
//       } catch (_) {
//         emit(TaskError());
//       }
//     });

//     on<AddTask>((event, emit) async {
//       try {
//         await databaseHelper.insertTask(event.task.toMap());
//         add(LoadTasks());
//       } catch (_) {
//         emit(TaskError());
//       }
//     });

//     on<UpdateTask>((event, emit) async {
//       try {
//         await databaseHelper.updateTask(event.task.toMap());
//         add(LoadTasks());
//       } catch (_) {
//         emit(TaskError());
//       }
//     });

//     on<DeleteTask>((event, emit) async {
//       try {
//         await databaseHelper.deleteTask(event.id);
//         add(LoadTasks());
//       } catch (_) {
//         emit(TaskError());
//       }
//     });
//   }
// }