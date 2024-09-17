import 'package:final_exam_nt/home_screen.dart';
import 'package:final_exam_nt/ui/screens/widgets/overview.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverviewScreen(),
    );
  }
}
