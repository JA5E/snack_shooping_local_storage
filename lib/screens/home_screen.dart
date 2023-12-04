import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rigel/util/todo_tile.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/main_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _productsBox = Hive.box('productsBox');
  final _cartBox = Hive.box('cartBox');
  //int _selectedMiniProductIndex = 0; // Track the selected MiniProduct index


  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
     if (_productsBox.get("productsList") == null) {
      db.createInitialData();
      db.updateDataBase();
    } else {
      db.cartFill();
      db.loadData();
    }

    super.initState();
  }

  // text controller
  late int _id = db.productsList.length - 1;
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

  int _parseInt(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      // Si ocurre un error durante la conversión, devolver 0
      return 0;
    }
  }

  double _parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      // Si ocurre un error durante la conversión, devolver 0.0
      return 0.0;
    }
  }

  // save new task
  void saveNewTask() {
    setState(() {
      List<String> restoredPhotos = _imagesController.text.split(", ");

      db.productsList.add({
        "id": db.productsList.last["id"] + 1,
        "title": _titleController.text,
        "description": _descriptionController.text,
        "category": _categoryController.text,
        "calories": _parseInt(_caloriesController.text),
        "additives": _parseInt(_additivesController.text),
        "vitamins": _parseInt(_vitaminsController.text),
        "price": _parseDouble(_priceController.text),
        "rank": _parseInt(_rankingController.text),
        "images": restoredPhotos,
        "quantity": _parseInt(_quantityController.text),
        "liked": false,
      });

      _titleController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      _caloriesController.clear();
      _additivesController.clear();
      _vitaminsController.clear();
      _priceController.clear();
      _rankingController.clear();
      _imagesController.clear();
      _quantityController.clear();
      _id = db.productsList.length - 1;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          MainProduct(
            id: _id,
            title: db.productsList[_id]["title"],
            liked: db.productsList[_id]["liked"],
            price: db.productsList[_id]["price"],
            rank: db.productsList[_id]["rank"],
            quantity: db.productsList[_id]["quantity"],
            img: db.productsList[_id]["images"][0],
            onChanged: (value) => checkBoxChanged(value, _id),
          ),
          Container(
            height: 80, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: db.productsList.length,
              itemBuilder: (context, index) {
                return MiniProduct(
                  img: db.productsList[index]["images"][0],
                  onTap: () {
                    // Set the selected MiniProduct index and update the MainProduct
                    setState(() {
                      _id=index;
                      //_selectedMiniProductIndex = index;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}