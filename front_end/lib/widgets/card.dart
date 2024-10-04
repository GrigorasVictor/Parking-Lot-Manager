import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, this.title, required this.content, this.height, this.width});
  final String? title;
  final String content;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(3, 5, 3, 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null)
              Text(title!, style: const TextStyle(fontWeight: FontWeight.bold)),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              elevation: 8,
              child: SizedBox(
                width: width ?? 200,
                height: height ?? 100,
                child: Center(
                    child: Text(content,
                        style: const TextStyle(fontWeight: FontWeight.bold))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
