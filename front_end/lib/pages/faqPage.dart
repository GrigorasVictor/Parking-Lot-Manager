import 'package:flutter/material.dart';
import 'package:front_end/sandBox/cookie_tester.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      // body: Text("Maybe a chatBot or cartonase cu FAQ(asta la final sa vedem cum legam totul)"),
      body: FutureBuilder<void>(
        future:
            sendRequestWithCookies("nice"), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If an error occurred, display an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If the Future is complete and has data, create a list of widgets
            List<String> items = ['snapshot.data!'];

            // Map each item to a widget, and return it as a ListView
            return ListView(
              children: items.map((item) {
                return ListTile(
                  title: Text(item),
                );
              }).toList(), // Convert Iterable to List<Widget>
            );
          } else {
            // If there's no data, display a "No data" message
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
