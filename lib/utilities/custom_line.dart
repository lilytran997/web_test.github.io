
import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget {
  final bool isVertical;
  final double size;
  final Color color;
  CustomLine({
    this.isVertical = true,
    this.size = 1, this.color,
  }) : assert(isVertical != null && size != null);

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Container(color: color??Colors.grey, height: size)
        : Container(color: color?? Colors.grey, width: size);
  }
}
