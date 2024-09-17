import 'package:final_exam_nt/home_screen.dart';
import 'package:flutter/material.dart';

class AddingIncomeScreen extends StatefulWidget {
  const AddingIncomeScreen({super.key});

  @override
  State<AddingIncomeScreen> createState() => _AddingIncomeScreenState();
}

class _AddingIncomeScreenState extends State<AddingIncomeScreen> {
  TextEditingController textAmount = TextEditingController();
  TextEditingController textCategory = TextEditingController();
  TextEditingController textComment = TextEditingController();
  TextEditingController textDate = TextEditingController();

  void _addIncome() {
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expensesa"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Total Salary \$\$\$"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: textCategory,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: const Text("Enter category")),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: textDate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: const Text("Enter date")),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: textAmount,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                label: const Text("Enter amount")),
                          ),
                        ],
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        FilledButton(
                            onPressed: () {}, child: const Text("Add")),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
        centerTitle: true,
      ),
      body: const Center(
        child: HomeScreen(),
      ),
    );
  }
}
