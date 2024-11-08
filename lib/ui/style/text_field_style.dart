
import 'package:flutter/material.dart';




InputDecoration TextFormFieldDecoration(String hintText) {
  return InputDecoration(
      fillColor: Colors.white10,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white70,
        fontSize: 18,
      ));
}