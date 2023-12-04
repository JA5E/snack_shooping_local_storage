import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rigel/screens/shoopingCart_screen.dart';
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
  List products = [];

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_productsBox.get("productsList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    if (_cartBox.get("cartList") == null) {
      db.createInitialDataCart();
      print(db.cartList);
    } else {
      db.loadDataCart();
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
        "addedToCart": false,
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
        title: const Text(''),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Implement the action when the back button is pressed
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Row with buttons
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Filter products based on the "Dried Fruits" category
                      products = db.productsList
                          .where((product) =>
                              product["category"] == "Dried Fruits")
                          .toList();
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/fruit.png', // Ruta de la imagen para "Dried Fruits"
                        width: 50,
                        height: 50,
                      ),
                      Text('Dried Fruits'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Filter products based on the "Dried Fruits" category
                      products = db.productsList;
                          
                    });
                  }, child: Text("ALL"),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // Filter products based on the "Nuts" category
                      products = db.productsList
                          .where((product) => product["category"] == "Nuts")
                          .toList();
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/nuts.png', // Ruta de la imagen para "Nuts"
                        width: 50,
                        height: 50,
                      ),
                      Text('Nuts'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // MainProduct widget
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
          // MiniProduct widget
          Container(
            height: 80, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return MiniProduct(
                  img: products[index]["images"][0],
                  onTap: () {
                    // Set the selected MiniProduct index and update the MainProduct
                    setState(() {
                      _id = index;
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
