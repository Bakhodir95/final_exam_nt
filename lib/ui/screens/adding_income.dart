import 'package:final_exam_nt/home_screen.dart';
import 'package:flutter/material.dart';

class AddingIncomeScreen extends StatefulWidget {
  const AddingIncomeScreen({super.key});

  @override
  State<AddingIncomeScreen> createState() => _AddingIncomeScreenState();
}

class _AddingIncomeScreenState extends State<AddingIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Income"),
          centerTitle: true,
        ),
        body: const Center(
          child: HomeScreen(),
        ));
  }
}
