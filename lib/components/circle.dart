import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final Color color;
  final double width, height;

  const Circle({
    super.key,
    this.color = Colors.green,
    this.width = 10,
    this.height = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    );
  }
}
