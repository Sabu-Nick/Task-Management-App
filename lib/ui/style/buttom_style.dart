
import 'package:flutter/material.dart';

ButtonStyle ElevatedButtonButtonStyle(){
  return ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(236, 30, 38, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      foregroundColor: Colors.white,
      fixedSize: Size.fromWidth(double.maxFinite),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      )
  );
}