import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final String imageUrl;

  const FullscreenImage({
    key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
