import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rigel/screens/camera.dart';
import 'screens/home_screen.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var productsBox = await Hive.openBox('productsBox');
var cartBox = await Hive.openBox('cartBox');
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.orange),
    );
  }
}



// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// List<CameraDescription>? cameras;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   CameraController? controller;
//   String imagePath = "";
//   List<String> photos = [];
//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(cameras![0], ResolutionPreset.medium);
//     controller?.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller!.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 50,
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 child: AspectRatio(
//                   aspectRatio: controller!.value.aspectRatio,
//                   child: CameraPreview(controller!),
//                 ),
//               ),
//               TextButton(
//                   onPressed: () async {
//                     try {
//                       final image = await controller!.takePicture();
//                       setState(() {
//                         imagePath = image.path;
                        
//                         photos.add(imagePath);
//                         print(photos);
//                       });
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   child: Text("Take Photo")),
//               if (imagePath != "")
//                 Container(
//                     width: 300,
//                     height: 300,
//                     child: Image.file(
//                       File(imagePath),
//                     )),
//                 TextButton(
//                     onPressed: () async {
//                       try {
//                         setState(() {
              
//                         });
//                       } catch (e) {
//                         print(e);
//                       }
//                     },
//                     child: Text("Use photos taken")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
