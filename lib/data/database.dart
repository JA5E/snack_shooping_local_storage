import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      {"id":1,
      "title": "Dried apricots",
       "description": "Artificial selection - Taste sweet",
       "category":"fruit",
       "calories": 90,
       "additives": 3,
       "vitamins": 8,
       "price":9.43,
       "ranking":4.5,
       "images":["image1","image2"],
       "quantity":300,
       "liked": true,
       },
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
