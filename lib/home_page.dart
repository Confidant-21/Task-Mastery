import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Data/database.dart';
import 'package:todo/util/dialBox.dart';
import 'package:todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDataBase();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        //backgroundColor: Color(0xFF2596be),
        appBar: AppBar(

          backgroundColor: Colors.transparent,

          //backgroundColor: Color(0xFF8A78A6),
          centerTitle: true,
          title: Text("Task Mastery",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center),
          elevation: 30,
          //leading: IconButton(
          //onPressed: () {},
          //icon: Icon(Icons.menu, color: Colors.black54),
          // ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
          autofocus: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF70A866),
            Color(0xFF647EA2),
            Color(0xFFB08BC7),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return todoTile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          ),
        ));
  }

  void saveNewTask() {
    //todoList.add([_controller.text, false]);
    setState(() {
      db.todoList.add([_controller.text, false]);
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }
}
