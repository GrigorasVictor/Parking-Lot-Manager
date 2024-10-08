import 'package:flutter/material.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/subscription.dart';
import 'package:front_end/model/user.dart';
import 'package:front_end/widgets/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:front_end/widgets/customButton.dart';
import 'package:front_end/widgets/listCard.dart';
import 'package:front_end/widgets/subscriptionCard.dart';
import 'package:intl/intl.dart';

// Define a constant mapping for subscription types
const Map<int, String> subscriptionTypeMap = {
  1: 'Monthly Subscription',
  2: 'Yearly Subscription',
  3: 'Lifetime Subscription',
};

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
    ListCardItem(
        title: subscriptionTypeMap[1]!,
        price: '\$4.99'), // Monthly Subscription
    ListCardItem(
        title: subscriptionTypeMap[2]!,
        price: '\$49.99'), // Yearly Subscription
    ListCardItem(
        title: subscriptionTypeMap[3]!,
        price: '\$99.99'), // Lifetime Subscription
  ];

  String currentPrice = '';
  String currentSubscription = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int selectedSubscriptionType = 0;

  // Function to calculate the end date based on subscription type
  void calculateEndDate(int subscriptionType) {
    if (subscriptionType == 1) {
      // Monthly Subscription
      endDate = DateTime(startDate.year, startDate.month + 1, startDate.day);
    } else if (subscriptionType == 2) {
      // Yearly Subscription
      endDate = DateTime(startDate.year + 1, startDate.month, startDate.day);
    } else if (subscriptionType == 3) {
      // Lifetime Subscription
      endDate = DateTime(startDate.year + 99, startDate.month, startDate.day);
    }
  }

  // Function to get the latest expiration date from the user's subscriptions
  DateTime getOldestExpirationDate(List<UserSubscription> subscriptions) {
    if (subscriptions.isEmpty) {
      return DateTime.now(); 
    }

    // Find the latest expiration date
    DateTime oldestEndDate = subscriptions.first.endDate;
    for (var sub in subscriptions) {
      if (sub.endDate.isAfter(oldestEndDate)) {
        oldestEndDate = sub.endDate;
      }
    }
    return oldestEndDate.add(const Duration(days: 1));
  }

  void _buySubscription(){
    User? user = UserSingleton.getUser(); 
                if (user != null && currentPrice.isNotEmpty) {
                  DateTime formattedDate = DateTime.now();
                  String description = '$currentSubscription payment';
                  sendTransaction(
                      user.userId, 
                      description, 
                      currentPrice, 
                      formattedDate 
                      );

                  sendSubscription(
                    user.userId, 
                    startDate, 
                    endDate,
                    0, 
                    selectedSubscriptionType 
                  );
                }
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Date format
    DateFormat dateFormatter = DateFormat('MM/dd/yyyy');

    // Retrieve user subscriptions
    List<UserSubscription> userSubscriptions =
        UserSingleton.getUser()!.subscriptions;
    print(userSubscriptions);

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

            // Swipeable Cards for User Subscriptions
            Expanded(
              child: PageView.builder(
                itemCount: userSubscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = userSubscriptions[index];
                  String title =
                      subscriptionTypeMap[subscription.subscriptionType] ??
                          'Unknown Subscription';
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(itemColorHighlighted),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: SubscriptionCard(
                      width: width * 0.9,
                      height: height * 0.2,
                      subscriptionText: title.toUpperCase(),
                      expirationDate:
                          dateFormatter.format(subscription.endDate),
                      svgBackgroundColor: const Color(itemColorHighlighted),
                    ),
                  );
                },
              ),
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

                    // Get the oldest expiration date from the user's subscriptions
                    startDate = getOldestExpirationDate(userSubscriptions);

                    // Calculate the end date based on the selected subscription
                    selectedSubscriptionType = subscriptionTypeMap.entries
                        .firstWhere(
                          (entry) => entry.value == selectedTitle,
                          orElse: () => const MapEntry(0, 'Unknown'),
                        )
                        .key;
                    calculateEndDate(selectedSubscriptionType);
                  });

                  print(
                      'Selected price: $currentPrice with $currentSubscription');
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 4,
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
                if(currentPrice.isNotEmpty && currentSubscription.isNotEmpty)
                  _showBuyDialog(context);
              },
              label: 'BUY',
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black, 
          title: const Text(
            "Buy Subscription",
            style: TextStyle(color: Colors.white), 
          ),
          content: Text(
            "Are you sure you want to purchase a ${currentSubscription} for ${currentPrice}?",
            style: const TextStyle(color: Colors.white),  
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.green), 
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text(
                "Buy",
                style: TextStyle(color: Colors.green), 
              ),
              onPressed: () {
                _buySubscription();
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }
  
}
