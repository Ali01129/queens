import 'package:flutter/material.dart';

void showCustomAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the alert dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}