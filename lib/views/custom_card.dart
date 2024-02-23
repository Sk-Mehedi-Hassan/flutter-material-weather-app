import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({required this.color, required this.child, super.key});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
