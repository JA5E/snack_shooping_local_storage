import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String title;
  final bool liked;
  final double price;
  final int quantity;
  final int rank;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.title,
    required this.liked,
    required this.price,
    required this.quantity,
    required this.rank,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            // First Column - Image
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber[900],
              ),
            ),
            Positioned(
              left: 60, // Adjust the left position as needed
              top: 0, // Align with the top of the circle
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("\$${price.toStringAsFixed(2)} / $quantity g"),
                  Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rank ? Icons.star : Icons.star_border,
                      color: index < rank ? Colors.white : Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
  onPressed: () {
    // Handle button press
    // You can add the logic for adding to cart here
  },
  child: Row(
    mainAxisSize: MainAxisSize.min, // Ensure the row takes only the necessary space
    children: [
      Icon(Icons.shopping_cart),
      SizedBox(width: 8), // Add some spacing between the icon and text
      Text("Add to Cart"),
    ],
  ),
),

                ],
              ),
            ),

            // Third Column - Like Icon in a Circle
            Positioned(
              left: 80, // Adjust the left position as needed
              top: 0, // Align with the top of the circle
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: liked ? Colors.red : Colors.grey,
                ),
                child: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    // Handle like button press
                    onChanged?.call(!liked);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
