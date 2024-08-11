import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageIcon();
}

class _SubscriptionPageIcon extends State<SubscriptionPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('subscriptionpage'),
      ),
    );
  }
}
