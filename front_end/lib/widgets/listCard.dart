import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

typedef OnItemTapCallback = void Function(String price, String title);

class ListCardItem {
  final String title;
  final String price;

  ListCardItem({required this.title, required this.price});
}

class ListCard extends StatelessWidget {
  final List<ListCardItem> items;
  final OnItemTapCallback onItemTap;

  const ListCard({super.key, required this.items, required this.onItemTap});

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
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1.0, color: Color.fromARGB(255, 187, 187, 187)),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onItemTap(items[index].price, items[index].title);
              },
              child: Container(
                height: 60, 
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.center, 
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
            );
          },
        ),
      ),
    );
  }
}
