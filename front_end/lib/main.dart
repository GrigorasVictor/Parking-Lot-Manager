import 'package:flutter/material.dart';
import 'package:front_end/pages/entryLoadingScreen.dart';
import 'package:front_end/pages/loginPage.dart'; 
import 'package:front_end/pages/signupPage.dart'; 
import 'package:front_end/widgets/navbar.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/load', // Start with the load page
      routes: {
        '/load': (context) => const EntryLoading(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/main': (context) => const MyHomePage(title: 'ParkWise'),
      },
    );
  }
}

// Main App Page After Successful Login
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
        title: Text(widget.title),
      ),
      bottomNavigationBar: const Navbar(),
      body: const Center(
        child: Text('Welcome to ParkWise!'),
      ),
    );
  }
}
