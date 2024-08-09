import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ParkingInfoList extends StatefulWidget {
  const ParkingInfoList({
    Key? key,
    required this.parkingId,
    this.parkingSpot,
    required this.onTap,
  }) : super(key: key);

  final String parkingId;
  final String? parkingSpot;
  final VoidCallback onTap;

  @override
  _ParkingInfoListState createState() => _ParkingInfoListState();
}

class _ParkingInfoListState extends State<ParkingInfoList> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  late String _formattedTime;
  late String _formattedDate;

  @override
  void initState() {
    super.initState();
    _formattedTime = '00:00:00';
    _formattedDate = DateFormat('MMM d').format(DateTime.now());
    _startTimer(); // Automatically start the timer when the widget is initialized
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        final hours = _elapsedSeconds ~/ 3600;
        final minutes = (_elapsedSeconds % 3600) ~/ 60;
        final seconds = _elapsedSeconds % 60;
        _formattedTime = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _elapsedSeconds = 0;
      _formattedTime = '00:00:00';
      _formattedDate = DateFormat('MMM d').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 8,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(
                        'lib/assets/icons/active.svg',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            'Parking Lot #${widget.parkingId}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            'Parking Spot: ${widget.parkingSpot ?? 'N/A'}',
                            style: const TextStyle(
                              color: Color(0xFFADBBB9),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            _formattedTime,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.right,
                          ),
                          AutoSizeText(
                            _formattedDate,
                            style: const TextStyle(
                              color: Color(0xFFADBBB9),
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
