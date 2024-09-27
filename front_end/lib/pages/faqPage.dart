import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Text("Maybe a chatBot or cartonase cu FAQ(asta la final sa vedem cum legam totul)"),
    );
  }
}
