import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }
}
