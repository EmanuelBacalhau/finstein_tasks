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
  Todo? todoDeleted;
  int? indexTodoDeleted;

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

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja apagar todas as tarefas?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        content: const Text('Essa ação não poderá ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(context),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Color(0xFF0D6FC6),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(context);
              removeAll();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text(
              'Limpar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  void removeAll() {
    setState(() {
      todos.clear();
    });
  }

  void removeTodo(Todo todo) {
    todoDeleted = todo;
    indexTodoDeleted = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Tarefa removida com sucesso!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: 'Desfazer',
          textColor: const Color(0xFF0D6FC6),
          onPressed: () {
            setState(() {
              todos.insert(indexTodoDeleted!, todoDeleted!);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF0D6FC6),
        title: Image.asset(
          'assets/images/finstein_gmbh_logo-removebg.png',
          height: 80,
        ),
      ),
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
                  onPressed: showDeleteTodosConfirmationDialog,
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
