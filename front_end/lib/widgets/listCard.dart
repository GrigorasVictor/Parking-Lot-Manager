import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Model to store title and price
class ListCardItem {
  final String title;
  final String price;

  ListCardItem({required this.title, required this.price});
}

// The Listcard widget
class Listcard extends StatelessWidget {
  final List<ListCardItem> items;
  final ValueChanged<String> onItemTap; // Callback to pass the selected price

  const Listcard({super.key, required this.items, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 5), // Shadow direction: bottom right
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ListView.separated(
          padding: const EdgeInsets.all(1.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 0.5, color: Color.fromARGB(255, 187, 187, 187)),
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: AutoSizeText(
                  items[index].title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              onTap: () {
                onItemTap(items[index].price); // Pass the selected price to the callback
              },
            );
          },
        ),
      ),
    );
  }
}