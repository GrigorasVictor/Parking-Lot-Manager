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

  const Listcard({Key? key, required this.items}) : super(key: key);

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
            offset: Offset(0, 5), // Shadow direction: bottom right
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true, // Ensure ListView takes only the necessary height
          physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: AutoSizeText(
                  items[index].title,
                  style: const TextStyle(fontSize: 22), // Set a base font size
                  maxLines: 1, // Ensure text doesn't wrap
                  overflow: TextOverflow.ellipsis, // Show ellipsis if text is too long
                ),
              ),
              onTap: () {
                // Handle tap on list item
                print('Selected: ${items[index].title} for ${items[index].price}');
              },
            );
          },
        ),
      ),
    );
  }
}
