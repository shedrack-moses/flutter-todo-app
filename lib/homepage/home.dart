// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/todo_database.dart';
import 'package:todo_app/utlities/dialogbox.dart';
import 'package:todo_app/utlities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _myBox = Hive.box('myBox');

  TodoDataBase db = TodoDataBase();
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

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updataDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updataDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            onSave: () => saveNewTask(),
            onCancel: () => Navigator.of(context).pop(),
            controller: _controller,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updataDataBase();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.blue.withOpacity(0.5),
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Spacer(),
              const Divider(
                thickness: 3,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text("TODO"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.yellow.shade200,
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, int index) {
              return TodoTile(
                taskname: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChage: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
