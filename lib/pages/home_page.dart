import 'package:finstein_tasks/models/todo.dart';
import 'package:finstein_tasks/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];

  final TextEditingController todoController = TextEditingController();

  void addTodo() {
    String title = todoController.text;

    if (title.isEmpty) {
      return;
    }

    Todo todo = Todo(
      title: title,
    );

    setState(() {
      todos.add(
        todo,
      );
    });
    todoController.clear();
  }

  void removeAll() {
    setState(() {
      todos.clear();
    });
  }

  void removeTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF0D6FC6),
          title: const Text(
            'Finstein Tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Ex: Estudar Flutter',
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF0D6FC6),
                        width: 2,
                      )),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF0D6FC6),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: addTodo,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(14),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0D6FC6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 26,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              fit: FlexFit.tight,
              child: ListView(
                shrinkWrap: true,
                children: todos
                    .map((todo) => TodoListItem(
                          todo: todo,
                          removeTodo: removeTodo,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child:
                        Text('Você possui ${todos.length} tarefas pendentes')),
                ElevatedButton(
                  onPressed: removeAll,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF0D6FC6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Limpar'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
