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
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth * 0.8; // Adjust width as a percentage of available space
        final double height = constraints.maxHeight * 0.6; // Adjust height as a percentage of available space

        return Container(
          margin: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: Card(
                elevation: 8,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0), // Reduced vertical padding
                      child: Text(
                        'Select date',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 18, // Reduced font size
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduced vertical padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Optionally handle cancel logic
                            },
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              widget.onDateSelected(_selectedDate);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
