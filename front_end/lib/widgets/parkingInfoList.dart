import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// ignore: must_be_immutable
class ParkingInfoList extends StatefulWidget {
  ParkingInfoList({
    super.key,
    required this.parkingId,
    this.parkingSpot,
    required this.onTap,
    this.initialHours,
    this.initialMinutes,
    this.initialSeconds,
    required this.activeCars,
    required this.totalSpots,
  });

  final String parkingId;
  String? parkingSpot;
  final VoidCallback onTap;
  int? initialHours;
  int? initialMinutes;
  int? initialSeconds;
  int activeCars;
  int totalSpots;

  @override
  _ParkingInfoListState createState() => _ParkingInfoListState();
}

class _ParkingInfoListState extends State<ParkingInfoList> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  late String _formattedTime;
  late String _formattedDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _formattedDate = DateFormat('MMM d').format(DateTime.now());
    _formattedTime = 'Loading...';

    Future.delayed(Duration.zero, () {
      setState(() {
        if (_isInactive(widget)) {
          _formattedTime = 'Inactive';
        } else {
          _startTimer(); // Start timer with the given initial time
        }
        _isLoading = false;
      });
    });
  }

  @override
  void didUpdateWidget(covariant ParkingInfoList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the initial time values have changed and reset the timer accordingly
    if (_hasTimeChanged(oldWidget)) {
      resetAndStartTimer(
        hours: widget.initialHours ?? -1,
        minutes: widget.initialMinutes ?? -1,
        seconds: widget.initialSeconds ?? -1,
      );
    }
  }

  bool _isInactive(ParkingInfoList widget) {
    return widget.initialHours == -1 || widget.initialMinutes == -1 || widget.initialSeconds == -1;
  }

  bool _hasTimeChanged(ParkingInfoList oldWidget) {
    return widget.initialHours != oldWidget.initialHours ||
        widget.initialMinutes != oldWidget.initialMinutes ||
        widget.initialSeconds != oldWidget.initialSeconds;
  }

  int _convertToSeconds({required int hours, required int minutes, required int seconds}) {
    return hours * 3600 + minutes * 60 + seconds;
  }

  // Public function to reset and start the timer using hours, minutes, and seconds
  void resetAndStartTimer({required int hours, required int minutes, required int seconds}) {
    _timer?.cancel(); // Cancel any existing timer

    if (hours == -1 || minutes == -1 || seconds == -1) {
      setState(() {
        _formattedTime = 'Inactive'; // Mark as inactive
        widget.initialHours = -1;
        widget.initialMinutes = -1;
        widget.initialSeconds = -1;
      });
    } else {
      // Convert the time to total seconds and start the timer
      int totalSeconds = _convertToSeconds(hours: hours, minutes: minutes, seconds: seconds);
      _startTimer(initialSeconds: totalSeconds);
    }
  }

  // Timer function to start counting from the provided total seconds
  void _startTimer({int initialSeconds = 0}) {
    _timer?.cancel();
    _elapsedSeconds = initialSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        final hours = _elapsedSeconds ~/ 3600;
        final minutes = (_elapsedSeconds % 3600) ~/ 60;
        final seconds = _elapsedSeconds % 60;
        _formattedTime =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                      _isInactive(widget)
                          ? 'lib/assets/icons/inactive.svg'
                          : 'lib/assets/icons/active.svg',
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
                        Row(
                          children: [
                            AutoSizeText(
                              'Parking Spot: ${widget.parkingSpot ?? '-'}',
                              style: const TextStyle(
                                color: Color(0xFFADBBB9),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(width: 10),
                            AutoSizeText(
                              '${widget.activeCars}/${widget.totalSpots}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _isLoading
                            ? [
                                const CircularProgressIndicator(),
                              ]
                            : [
                                AutoSizeText(
                                  _formattedTime,
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                  maxLines: 1,
                                  textAlign: TextAlign.right,
                                ),
                                AutoSizeText(
                                  _formattedDate,
                                  style: TextStyle(
                                    color: _isInactive(widget)
                                        ? const Color(0xFFADBBB9).withOpacity(0.5)
                                        : const Color(0xFFADBBB9),
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
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                splashColor: const Color(0xFFADBBB9).withOpacity(0.1),
                highlightColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
