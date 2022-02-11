import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  String text;
  Function onPressed;

  FormSubmitButton({
    @required String text,
    Function onPressed}) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 20.0),
    ),
    color: Colors.indigo,
    borderRadius: 4.0,
    onPressed: onPressed
  );
}