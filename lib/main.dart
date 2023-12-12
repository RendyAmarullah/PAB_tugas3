import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Picture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Take Picture'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _imageFile = '';
  final picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final PickedFile = await picker.pickImage(source: source);
    if (PickedFile != null) {
      setState(() {
        _imageFile = PickedFile.path;
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Image Source',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop(_getImage(ImageSource.gallery));
              },
            ),
            ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop(_getImage(ImageSource.camera));
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _imageFile.isNotEmpty
                ? Image.file(
                    File(_imageFile),
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
                    height: 250,
                    width: double.infinity,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _showPicker, child: const Text('Take Picture'))
          ],
        ),
      ),
    );
  }
}
