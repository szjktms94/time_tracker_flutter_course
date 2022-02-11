import 'dart:developer';

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;
  final double borderRadius;//todo use it

  const CustomElevatedButton({this.child, this.onPressed, this.color, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius) : BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)
          )
      ),
      backgroundColor: MaterialStateProperty.all(color)
    ),
    onPressed: onPressed, child: child,);
  }
}
