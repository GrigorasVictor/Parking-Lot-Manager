import 'package:flutter/material.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/customButton.dart';
import 'package:front_end/widgets/listCard.dart'; 
import 'package:front_end/widgets/subscriptionCard.dart';
import 'package:intl/intl.dart';

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
    ListCardItem(title: 'Monthly Subscription', price: '\$4.99'),
    ListCardItem(title: 'Yearly Subscription', price: '\$49.99'),
    ListCardItem(title: 'Lifetime Subscription', price: '\$99.99'),
  ];

  String currentPrice = ''; 
  String currentSubscription = '';
  DateTime startDate = DateTime.now(); 
  DateTime endDate = DateTime.now(); 

  void calculateEndDate(String subscription) {
    DateTime today = DateTime.now();
    if (subscription == 'Monthly Subscription') {
      endDate = DateTime(today.year, today.month + 1, today.day);
    } else if (subscription == 'Yearly Subscription') {
      endDate = DateTime(today.year + 1, today.month, today.day);
    } else if (subscription == 'Lifetime Subscription') {
      endDate = DateTime(today.year + 99, today.month, today.day); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Date format
    DateFormat dateFormatter = DateFormat('MM/dd/yyyy');

    return Scaffold(
      backgroundColor: const Color(itemColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              height: height * 0.14,
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
            Expanded(
              flex: 2,
              child: Listcard(
                items: subscriptionOptions,
                onItemTap: (selectedPrice, selectedTitle) {
                  setState(() {
                    currentPrice = selectedPrice;
                    currentSubscription = selectedTitle;
                    startDate = DateTime.now();
                    calculateEndDate(currentSubscription);
                  });
                  print('Selected price: $currentPrice with $currentSubscription');
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                // Total Price Card
                Expanded(
                  flex: 4, // 40% of the available width
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),
                        AutoSizeText(
                          currentPrice.isEmpty ? '\$0.00' : currentPrice,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Calendar Card
                Expanded(
                  flex: 6, 
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
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
                    child: Column(
                      children: [
                        const AutoSizeText(
                          'From:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          dateFormatter.format(startDate),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        const AutoSizeText(
                          'To:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        AutoSizeText(
                          dateFormatter.format(endDate),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomElevatedButton(
              width: width,
              height: height * 0.04,
              minHeight: 15,
              onPressed: () {
                sendTransaction(5, currentSubscription, currentPrice, startDate);
                sendSubscription(3, startDate, endDate, 0);
              },
              label: 'BUY',
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
