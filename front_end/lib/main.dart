import 'package:flutter/material.dart';
import 'package:front_end/widgets/cardIcon.dart';
import 'package:front_end/widgets/parkingInfoList.dart'; // Make sure this import is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomCardIcon(
              icon: Image.asset('lib/assets/icons/account.png'),
              title: 'Account',
              height: 150,
              width: 125,
              onTap: () => print('Account tapped'),
            ),
            ParkingInfoList(
              parkingId: '3',
              parkingSpot: '4',
              onTap: () => print('ParkingInfoList tapped'),
            ),
          ],
        ),
      ),
    );
  }
}
