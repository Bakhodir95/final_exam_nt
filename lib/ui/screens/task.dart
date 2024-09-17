
import 'package:final_exam_nt/bloc/expense_bloc.dart';
import 'package:final_exam_nt/bloc/expense_state.dart';
import 'package:final_exam_nt/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpanseLaoding) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExpanseLaoded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<ExpenseBloc>().add(UpdateExpense(Expenses(
                          id: exp.id,
                          title: task.title,
                          isCompleted: value ?? false)));
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTask(task.id!));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Error loading tasks'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
  
  void _addTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Task Title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final task = Expenses(title: _controller.text);
                context.read<TaskBloc>().add(AddTask(task));
                Navigator.pop(context);
                _controller.clear();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
