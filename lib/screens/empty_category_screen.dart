import 'package:flutter/material.dart';

class EmptyCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 3);
          },
        ),
      ),
      body: Center(
        child: const Text("No items in this category"),
      ),
    );
  }
}
