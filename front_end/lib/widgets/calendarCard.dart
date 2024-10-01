import 'package:flutter/material.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({
    super.key,
    required this.onDateSelected,
  });

  final ValueChanged<DateTime> onDateSelected;

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Center(
        child: Card(
          elevation: 8,
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Select date',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Colors.white,
                      colorScheme: const ColorScheme.light(
                        primary: Colors.green, 
                        onPrimary: Colors.white, 
                        onSurface: Colors.black, 
                        surface: Colors.white, 
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green, 
                        ),
                      ),
                    ),
                    child: CalendarDatePicker(
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (picked) {
                        setState(() {
                          _selectedDate = picked;
                        });
                        widget.onDateSelected(picked);
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
