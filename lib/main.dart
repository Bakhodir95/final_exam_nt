import 'package:final_exam_nt/bloc/expense_bloc.dart';
import 'package:final_exam_nt/bloc/expense_event.dart';
import 'package:final_exam_nt/home_screen.dart';
import 'package:final_exam_nt/ui/screens/overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ExpanseBloc(DatabaseHelper())..add(LoadExpense()),
        child: OverviewScreen(),
      ),
    );
  }
}
