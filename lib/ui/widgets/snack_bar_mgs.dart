import 'package:flutter/material.dart';

void SnackBarMessages(BuildContext context, String messages, [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        messages,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? Colors.red : Colors.green, // Default to green for success
      duration: Duration(seconds: 2),
    ),
  );
}
