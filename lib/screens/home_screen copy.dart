// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../data/database.dart';
// import '../util/dialog_box.dart';
// import '../util/todo_tile.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // reference the hive box
//   final _myBox = Hive.box('mybox');
//   ToDoDataBase db = ToDoDataBase();

//   @override
//   void initState() {
//     // if this is the 1st time ever openin the app, then create default data
//     if (_myBox.get("productsList") == null) {
//       db.createInitialData();
//     } else {
//       // there already exists data
//       db.loadData();
//     }

//     super.initState();
//   }

//   // text controller
//   final _controller = TextEditingController();

//   // checkbox was tapped
//   void checkBoxChanged(bool? value, int index) {
//     setState(() {
//       db.productsList[index]["liked"] = !db.productsList[index]["liked"];
//     });
//     db.updateDataBase();
//   }

//   // save new task
//   void saveNewTask() {
//     setState(() {
//       db.productsList.add([_controller.text, false]);
//       _controller.clear();
//     });
//     Navigator.of(context).pop();
//     db.updateDataBase();
//   }

//   // create a new task
//   void createNewTask() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return DialogBox(
//           controller: _controller,
//           onSave: saveNewTask,
//           onCancel: () => Navigator.of(context).pop(),
//         );
//       },
//     );
//   }

//   // delete task
//   void deleteTask(int index) {
//     setState(() {
//       db.productsList.removeAt(index);
//     });
//     db.updateDataBase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       appBar: AppBar(
//         title: Text('TO DO'),
//         elevation: 0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: createNewTask,
//         child: Icon(Icons.add),
//       ),
//       body: ListView.builder(
//         itemCount: db.productsList.length,
//         itemBuilder: (context, index) {
//           return ToDoTile(
//             taskName: db.productsList[index]["title"],
//             taskCompleted: db.productsList[index]["liked"],
//             onChanged: (value) => checkBoxChanged(value, index),
//             deleteFunction: (context) => deleteTask(index),
//           );
//         },
//       ),
//     );
//   }
// }
