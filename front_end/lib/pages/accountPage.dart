import 'package:flutter/material.dart';
import 'package:front_end/widgets/userShower.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final double textSize = 50;
  final String font = 'Inter';
  final double iconSize = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text('accountpage'),
        child: UserShower(2),
      ),
    );
  }
}
