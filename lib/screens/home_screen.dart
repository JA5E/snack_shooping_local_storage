import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _productsBox = Hive.box('productsBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_productsBox.get("productsList") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _additivesController = TextEditingController();
  final _vitaminsController = TextEditingController();
  final _priceController = TextEditingController();
  final _rankingController = TextEditingController();
  final _imagesController = TextEditingController();
  final _quantityController = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.productsList[index]["liked"] = !db.productsList[index]["liked"];
    });
    db.updateDataBase();
    print(_titleController);
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.productsList.add(
        {"id":db.productsList.last["id"]+1,
        "title":_titleController.text,
        "description": _descriptionController.text,
       "category": _categoryController.text,
       "calories": int.parse(_caloriesController.text),
       "additives": int.parse(_additivesController.text),
       "vitamins": int.parse(_vitaminsController.text),
       "price": int.parse(_priceController.text),
       "ranking": int.parse(_rankingController.text),
       "images":[_imagesController.text],
       "quantity":int.parse(_quantityController.text),
         "liked":false,
        });
      _titleController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    print(db.productsList);
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          titleController: _titleController,
          descriptionController: _descriptionController,
          categoryController: _categoryController,
          caloriesController: _caloriesController,
          additivesController: _additivesController,
          vitaminsController: _vitaminsController,
          priceController: _priceController,
          rankingController: _rankingController,
          imagesController: _imagesController,
          quantityController: _quantityController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.productsList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.productsList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.productsList[index]["title"],
            taskCompleted: db.productsList[index]["liked"],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
