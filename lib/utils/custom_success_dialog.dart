import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sucesso!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pushNamed(context, title);
            },
          ),
        ],
      );
    },
  );
}
