import 'dart:io';
import 'package:flutter/material.dart';

class MiniProduct extends StatelessWidget {
  final String img;

  MiniProduct({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: 80, // Adjust the width as needed
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Execute your action here when the image is clicked
                print('Image Clicked!');

                // You can replace the print statement with the desired action
                // For example, navigate to a new screen:
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YourNewScreen()));
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2.0),
                ),
                child: Image.file(
                  File(img),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
