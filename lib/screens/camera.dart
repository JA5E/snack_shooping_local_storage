// camera_screen.dart

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  final String title;
  final Function(List<String>) onPhotosTaken; // Callback function

  CameraScreen({Key? key, required this.title, required this.onPhotosTaken}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  String imagePath = "";
  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![0], ResolutionPreset.medium);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final image = await controller!.takePicture();
                    setState(() {
                      imagePath = image.path;
                      photos.add(imagePath);
                      print(photos);
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Take Photo"),
              ),
              if (imagePath != "")
                Container(
                  width: 300,
                  height: 300,
                  child: Image.file(
                    File(imagePath),
                  ),
                ),
              TextButton(
                onPressed: () async {
                  try {
                    // Call the callback function and pass the list of photos
                    widget.onPhotosTaken(photos);
                    setState(() {});
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Use photos taken"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
