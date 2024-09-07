import 'package:flutter/material.dart';

class UploadPopup extends StatelessWidget {
  final String message;
  final bool isSuccess;
  final VoidCallback onPressed;

  const UploadPopup({
    super.key,
    required this.message,
    required this.isSuccess,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isSuccess ? 'Upload Successful' : 'Upload Failed'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}