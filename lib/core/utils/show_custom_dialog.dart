import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0XFF004567),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
