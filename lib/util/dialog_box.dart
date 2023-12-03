import 'package:flutter/material.dart';

import 'my_button.dart';

class DialogBox extends StatelessWidget {
  final titleController;
  final descriptionController;
  final categoryController;
  final caloriesController;
  final additivesController;
  final vitaminsController;
  final priceController;
  final rankingController;
  final imagesController;
  final quantityController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.categoryController,
    required this.caloriesController,
    required this.additivesController,
    required this.vitaminsController,
    required this.priceController,
    required this.rankingController,
    required this.imagesController,
    required this.quantityController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Color(0xFFFFC476),
        content: Container(
          //height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // get user input
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                ),
              ),
      
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Category",
                ),
              ),
              TextField(
                controller: caloriesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Calories",
                ),
              ),
              TextField(
                controller: additivesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Additives",
                ),
              ),
              TextField(
                controller: vitaminsController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Vitamins",
                ),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Price",
                ),
              ),
              TextField(
                controller: rankingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ranking",
                ),
              ),
              TextField(
                controller: imagesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Images",
                ),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Quantity",
                ),
              ),
      
              // buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(text: "Save", onPressed: onSave),
      
                  const SizedBox(width: 8),
      
                  // cancel button
                  MyButton(text: "Cancel", onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
