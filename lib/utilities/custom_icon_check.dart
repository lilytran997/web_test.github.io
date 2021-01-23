
import 'package:flutter/material.dart';

class CustomIconCheck extends StatelessWidget {
  final bool isCircle;
  final double height;
  final double width;
  final bool isSelected;
  const CustomIconCheck(
      {Key key,
      this.isCircle = false,
      this.height = 25.0,
      this.width = 25.0,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircle
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey, width: 1),
              color: isSelected ?  Colors.blue  : Colors.white,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20.0,
              ),
            ))
        : Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                border: Border.all(
                    color: isSelected ?Colors.blue : Colors.grey, width: 1),
                color: isSelected ? Colors.blue  : Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(4.0))),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20.0,
              ),
            ));
  }
}
