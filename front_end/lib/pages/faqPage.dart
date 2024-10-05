import 'package:flutter/material.dart';
import 'package:front_end/widgets/carCard.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
       body: CarCard(descriptionText: "AB22ADC", onClose: (){}),
    );

    
  }
}
