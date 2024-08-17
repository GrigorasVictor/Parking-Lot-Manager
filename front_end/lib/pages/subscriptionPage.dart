import 'package:flutter/material.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/customButton.dart';
import 'package:front_end/widgets/listCard.dart'; // Import the Listcard widget
import 'package:front_end/widgets/subscriptionCard.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  final List<ListCardItem> subscriptionOptions = [
    ListCardItem(title: 'Monthly Subscription', price: '\$9.99'),
    ListCardItem(title: 'Yearly Subscription', price: '\$99.99'),
    ListCardItem(title: 'Lifetime Subscription', price: '\$299.99'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color(itemColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const AutoSizeText(
                'Subscription',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 5),
              SubscriptionCard(
                width: width * 0.9,
                height: 100.0,
                subscriptionText: "PREMIUM SUBSCRIPTION",
                expirationDate: "12/31/2024",
                svgBackgroundColor: const Color(itemColorHighlighted),
              ),
              const SizedBox(height: 15),
              const AutoSizeText(
                'Buy subscription',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 5),
              Listcard(
                items: subscriptionOptions, // Pass the subscription options here
              ),
              const SizedBox(height: 15),
              CustomElevatedButton(
                width: width,
                height: height * 0.04,
                minHeight: 15,
                onPressed: () {
                  // Handle the "BUY" button press
                  print('Buy button pressed');
                },
                label: 'BUY',
                fontSize: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
