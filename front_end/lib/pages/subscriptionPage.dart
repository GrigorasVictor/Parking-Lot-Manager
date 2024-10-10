import 'package:flutter/material.dart';
import 'package:front_end/logic/httpReq.dart';
import 'package:front_end/logic/userSingleTon.dart';
import 'package:front_end/model/subscription.dart';
import 'package:front_end/model/subscriptionPlan.dart';
import 'package:front_end/model/user.dart';
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
  String currentPrice = '';
  String currentSubscription = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int selectedSubscriptionType = 0;
  List<UserSubscription> userSubscriptions = [];

  @override
  void initState() {
    super.initState();
    userSubscriptions = UserSingleton.getUser()!.subscriptions;
  }

  void calculateEndDate(int timeLength) {
    endDate =
        DateTime(startDate.year, startDate.month + timeLength, startDate.day);
  }

  DateTime getOldestExpirationDate() {
    if (userSubscriptions.isEmpty) {
      return DateTime.now();
    }
    DateTime oldestEndDate = userSubscriptions.first.endDate;
    for (var sub in userSubscriptions) {
      if (sub.endDate.isAfter(oldestEndDate)) {
        oldestEndDate = sub.endDate;
      }
    }
    return oldestEndDate.add(const Duration(days: 1));
  }

  void _buySubscription() async {
    User? user = UserSingleton.getUser();
    if (user != null && currentPrice.isNotEmpty) {
      DateTime formattedDate = DateTime.now();
      String description = '$currentSubscription payment';

      await sendTransaction(
        user.userId,
        description,
        currentPrice,
        formattedDate,
      );

      await sendSubscription(
        user.userId,
        startDate,
        endDate,
        currentSubscription.replaceAll(' Subscription', ''),
      );

      setState(() {
        userSubscriptions.add(UserSubscription(
          subscriptionId: 0,
          userId: user.userId,
          subscriptionType: currentSubscription.replaceAll(' Subscription', ''),
          startDate: getOldestExpirationDate(),
          endDate: endDate,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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

            // Check if userSubscriptions is empty
            if (userSubscriptions.isEmpty) ...[
              const Expanded(
                child: Center(
                  child: Text(
                    'No subscriptions found.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: PageView.builder(
                  itemCount: userSubscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = userSubscriptions[index];
                    String title =
                        "${subscription.subscriptionType} Subscription"; 
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
            ],

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
              child: FutureBuilder<List<SubscriptionPlan>>(
                future: getSubscriptionOptions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    print(snapshot.data);
                    List<SubscriptionPlan> listOptionsSubs = snapshot.data!;

                    final List<ListCardItem> subscriptionOptions =
                        listOptionsSubs
                            .map((plan) => ListCardItem(
                                  title: '${plan.name} Subscription',
                                  price: plan.price.toString(),
                                ))
                            .toList();

                    return ListCard(
                      items: subscriptionOptions,
                      onItemTap: (selectedPrice, selectedTitle) {
                        setState(() {
                          currentPrice = selectedPrice;
                          currentSubscription = selectedTitle;
                          startDate = getOldestExpirationDate();

                          SubscriptionPlan selectedPlan =
                              listOptionsSubs.firstWhere(
                            (plan) =>
                                '${plan.name} Subscription' == selectedTitle,
                            orElse: () =>
                                throw Exception('Subscription not found'),
                          );

                          selectedSubscriptionType = selectedPlan.id;
                          calculateEndDate(selectedPlan.timeLength);
                        });

                        print(
                            'Selected price: $currentPrice with $currentSubscription');
                      },
                    );
                  } else {
                    return const Center(
                        child: Text('No subscription options available.'));
                  }
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
                          currentPrice.isEmpty ? '\$0.00' : '\$$currentPrice',
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
                if (currentPrice.isNotEmpty && currentSubscription.isNotEmpty) {
                  _showBuyDialog(context);
                }
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
          backgroundColor: Colors.grey[300], 
          title: const Text('Confirm Purchase'),
          content: const Text(
              'Are you sure you want to purchase this subscription?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, 
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      color: Colors.white)), 
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                _buySubscription();
                Navigator.of(context).pop(); 
                _showSuccessDialog(context, true); 
              },
              child: const Text('Confirm',
                  style: TextStyle(
                      color: Colors.white)), 
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300], 
          title: Text(success ? 'Purchase Successful' : 'Purchase Failed'),
          content: Text(success
              ? 'Your subscription has been purchased successfully.'
              : 'There was an error completing your purchase.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('OK',
                  style: TextStyle(
                      color: Colors.white)), 
            ),
          ],
        );
      },
    );
  }
}
