import 'dart:io';

import 'package:flutter/material.dart';

class MainProduct extends StatelessWidget {
  final String title;
  final bool liked;
  final double price;
  final int quantity;
  final int rank;
  final String img;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  MainProduct({
    Key? key,
    required this.title,
    required this.liked,
    required this.price,
    required this.quantity,
    required this.rank,
    required this.img,
    required this.onChanged,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenWidth * 0.8, // 80% of screen width
          height: screenWidth * 0.8, // 80% of screen width
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber[900],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align vertically centered
            children: [
              // Image Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: screenWidth * 0.25, // Adjust as needed
                    height: screenWidth * 0.25, // Adjust as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                    child: Image.file(
                      File(img), // Replace with your image path
                      fit: BoxFit.scaleDown,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        print('Error loading image: $error');
                        print('StackTrace: $stackTrace');
                        return const Center(
                          child: Text(
                            'Image not found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(width: screenWidth * 0.02), // Adjust as needed

              // Text Content Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: screenWidth * 0.03), // Adjust as needed
                        Text(
                          "\$${price.toStringAsFixed(2)} / $quantity g",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: screenWidth * 0.03), // Adjust as needed
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < rank ? Icons.star : Icons.star_border,
                              color: index < rank ? Colors.white : Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: screenWidth * 0.03), // Adjust as needed
                        // Add to Cart Button
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                            // You can add the logic for adding to cart here
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 8), // Adjust as needed
                              Text("Add to cart"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(width: screenWidth * 0.02), // Adjust as needed

              // Like Icon Column
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.1, // Adjust as needed
                    height: screenWidth * 0.1, // Adjust as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle like button press
                        onChanged?.call(!liked);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
