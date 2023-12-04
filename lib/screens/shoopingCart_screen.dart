import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rigel/data/database.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _productsBox = Hive.box('productsBox');
  final _cartBox = Hive.box('cartBox');
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
    } else {
      db.loadDataCart();
    }

    super.initState();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var cartItem in db.cartList) {
      int productId = cartItem[0];
      int quantity = cartItem[1];
      double productPrice = db.productsList[productId]["price"];
      totalPrice += productPrice * quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.amber[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var cartItem in db.cartList)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product Image
                    Container(
                      width: 100,
                      child: Image.file(
                        File(db.productsList[cartItem[0]]["images"][0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Product Title
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          db.productsList[cartItem[0]]["title"],
                          style: TextStyle(color: Colors.white),
                        ),
                        // Product Price
                        Text(
                          "\$${db.productsList[cartItem[0]]["price"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Quantity Adjustment Buttons
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              cartItem[1]--;
                              if (cartItem[1] < 1) {
                                db.cartList.remove(cartItem);
                              }
                            });
                            // Update cartList and screen accordingly
                          },
                        ),
                        Text(
                          "${cartItem[1]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // Implement logic to increase quantity
                            setState(() {
                              cartItem[1]++;
                            });
                            // Update cartList and screen accordingly
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
  padding: EdgeInsets.all(16.0),
  child: ElevatedButton(
    onPressed: () {
      // Implement any action when the total price button is pressed
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // background color
      foregroundColor: Colors.yellow, // text color
    ),
    child: Text(
      " Items: ${db.cartList.length}   |  \$${calculateTotalPrice().toStringAsFixed(2)} Buy Now",
      style: TextStyle(fontSize: 24),
    ),
  ),
),

    );
  }
}
  