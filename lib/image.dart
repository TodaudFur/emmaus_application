import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final imageBytes;

  const ImagePage({Key key, this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          Center(
            child: Image.memory(
              imageBytes,
              width: 1080,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
