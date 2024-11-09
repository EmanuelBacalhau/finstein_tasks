import 'package:finstein_tasks/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({super.key, required this.todo});

  get formattedDate => DateFormat(
        'dd/MM/yyyy - HH:mm:ss',
      ).format(todo.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              padding: EdgeInsets.zero,
              onPressed: (_) => {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Remover ',
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.grey[850],
                  fontSize: 14,
                ),
              ),
              Text(
                todo.title,
                style: TextStyle(
                  color: Colors.grey[850],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
