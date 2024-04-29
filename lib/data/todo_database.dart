//reference the box
import 'package:hive/hive.dart';

class TodoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('myBox');
  void createInitialData() {
    toDoList = [
      ["make tutorial", false],
      ["make tutorial", false],
    ];
  }

//load data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

// update database
  void updataDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

}
