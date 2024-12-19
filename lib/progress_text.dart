import 'package:flutter/material.dart';

class ProgressText extends StatelessWidget {
  final String actual;
  final String ideal;
  final String unit;
  const ProgressText({super.key, required this.actual, required this.ideal, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(actual,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,)),
        Text(ideal,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.normal,)),
        Text(unit,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.normal,))
      ],
    );
  }
}
