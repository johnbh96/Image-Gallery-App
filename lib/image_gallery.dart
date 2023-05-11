import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<String> _imageUrls = [
    "https://www.example.com/image1.jpg",
    "https://www.example.com/image2.jpg",
    "https://www.example.com/image3.jpg",
    "https://www.example.com/image4.jpg",
    "https://www.example.com/image5.jpg",
    "https://www.example.com/image6.jpg",
  ];

  GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gallery"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _imageUrls[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
