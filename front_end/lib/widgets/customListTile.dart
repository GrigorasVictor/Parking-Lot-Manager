import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), 
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 0), 
          child: Icon(icon, color: Colors.green),
        ),
        title: AutoSizeText(
          text,
          style: const TextStyle(fontSize: 16),
          maxLines: 2,
          minFontSize: 16,
        ),
      ),
    );
  }
}
