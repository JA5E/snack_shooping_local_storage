// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rigel/screens/camera.dart';

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
        backgroundColor: const Color(0xFFFFC476),
        content: Container(
          //height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // get user input
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                ),
              ),

              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                ),
              ),
              TextField(
  controller: categoryController,
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
    hintText: "Category",
  ),
  readOnly: true,
  onTap: () {
    showDialog(
      context: context,
      builder: (context) {
        String selectedCategory = categoryController.text;
        return AlertDialog(
          title: Text("Select Category"),
          content: Column(
            children: [
              ListTile(
                title: Text("Dried Fruits"),
                onTap: () {
                  Navigator.pop(context, "Dried Fruits");
                },
              ),
              ListTile(
                title: Text("Nuts"),
                onTap: () {
                  Navigator.pop(context, "Nuts");
                },
              ),
            ],
          ),
        );
      },
    ).then((selectedCategory) {
      if (selectedCategory != null) {
        categoryController.text = selectedCategory;
      }
    });
  },
),

              TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Calories",
                ),
              ),
              TextField(
                controller: additivesController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Additives",
                ),
              ),
              TextField(
                controller: vitaminsController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Vitamins",
                ),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // Cambiado para permitir números decimales
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}')), // Permitir hasta 2 decimales
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Price",
                ),
              ),

              TextField(
                controller: rankingController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Ranking",
                ),
              ),
              // Here is generatet the code for the button for displaying MyHomePage class in the file camera.dart
              // Here is the code for the button to navigate to MyHomePage class in the file camera.dart
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Quantity",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CameraScreen(
                              title: "Your Title",
                              onPhotosTaken: (List<String> photos) {
                                // Do something with the list of photos
                                print("Received photos: $photos");
                                String concatenatedPhotos = photos.join(", ");
                                imagesController.text = concatenatedPhotos;
                              },
                            )),
                  );
                },
                child: Text("Take Photos"),
              ),

              // buttons -> save + cancel
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // save button
                  MyButton(
                    text: "Save",
                    onPressed: () {
                      // Validar si todos los campos están completos
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          categoryController.text.isNotEmpty &&
                          caloriesController.text.isNotEmpty &&
                          additivesController.text.isNotEmpty &&
                          vitaminsController.text.isNotEmpty &&
                          priceController.text.isNotEmpty &&
                          rankingController.text.isNotEmpty &&
                          imagesController.text.isNotEmpty &&
                          quantityController.text.isNotEmpty) {
                        onSave();
                      } else {
                        // Mostrar un mensaje o realizar alguna acción cuando no todos los campos están completos
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "Completa todos los campos antes de guardar."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),

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
