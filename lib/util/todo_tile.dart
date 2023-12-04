import 'dart:io';
import 'package:flutter/material.dart';

class MiniProduct extends StatelessWidget {
  final String img;
  final VoidCallback onTap;

  MiniProduct({
    Key? key,
    required this.img,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GestureDetector(
        onTap: onTap, // Use the callback when the image is clicked
        child: Container(
          width: 80, // Adjust the width as needed
          height: 80, // Adjust the height as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.file(
              File(img),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
