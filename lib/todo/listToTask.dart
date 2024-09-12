import 'package:flutter/material.dart';

List<Task> listaTask = [];

class ListToTask extends StatefulWidget {
  const ListToTask({super.key});

  @override
  _ListToTaskState createState() => _ListToTaskState();
}

class _ListToTaskState extends State<ListToTask> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'lista de Tarefas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      centerTitle: true,
      toolbarHeight: 80,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: listaTask.length,
        itemBuilder: (BuildContext context, int index) {
          String descricao = listaTask[index].descricao;
          String data = listaTask[index].data;
          String hora = listaTask[index].hora;
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                listaTask.removeAt(index);
              });
            },
            child: ListTile(
              leading: const Icon(Icons.list),
              trailing: const Text(
                "GFG",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              title: Text("Tarefa: $descricao"),
              subtitle: Text("Data: $data - Hora: $hora"),
            ),
          );
        },
      ),
    );
  }
}

class Task {
  String descricao;
  String data;
  String hora;

  Task(this.descricao, this.data, this.hora);
}