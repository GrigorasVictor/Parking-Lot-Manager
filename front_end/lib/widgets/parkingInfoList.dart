import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'dart:async';

class ParkingInfoList extends StatefulWidget {
  ParkingInfoList({
    super.key,
    required this.parkingId,
    this.parkingSpot,
    required this.onTap,
    this.initialHours,
    this.initialMinutes,
    this.initialSeconds,
  });

  final String parkingId;
  String? parkingSpot;
  final VoidCallback onTap;
  final int? initialHours;
  final int? initialMinutes;
  final int? initialSeconds;

  @override
  _ParkingInfoListState createState() => _ParkingInfoListState();
}

class _ParkingInfoListState extends State<ParkingInfoList> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  late String _formattedTime;
  late String _formattedDate;
  bool _isLoading = true;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _formattedDate = DateFormat('MMM d').format(DateTime.now());
    _formattedTime = 'Loading...';

    Future.delayed(Duration.zero, () {
      setState(() {
        if (widget.initialHours == -1 ||
            widget.initialMinutes == -1 ||
            widget.initialSeconds == -1) {
          _setInactive();
        } else {
          _isActive = true;
          _startTimerWithInitialTime();
        }
        _isLoading = false;
      });
    });
  }

  void _startTimerWithInitialTime() {
    final int initialSeconds = (widget.initialHours ?? 0) * 3600 +
        (widget.initialMinutes ?? 0) * 60 +
        (widget.initialSeconds ?? 0);

    if (initialSeconds >= 0) {
      _startTimer(initialSeconds: initialSeconds);
    } else {
      _setInactive(); // Handle invalid time
    }
  }

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

  void _setInactive() {
    setState(() {
      _isActive = false;
      _formattedTime = 'Inactive';
      widget.parkingSpot = '-';
      _timer?.cancel();
    });
  }

  void _setActive() {
    setState(() {
      _isActive = true;
      _formattedTime = '00:00:00';
      widget.parkingSpot = 'A${widget.parkingId}';
    });

    final int initialSeconds = (widget.initialHours ?? 0) * 3600 +
        (widget.initialMinutes ?? 0) * 60 +
        (widget.initialSeconds ?? 0);
        
    if (initialSeconds >= 0) {
      _startTimer(initialSeconds: initialSeconds);
    } else {
      _setInactive(); // Handle invalid time
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Transparent background for the container
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.zero, // Ensure no padding
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
                      _isActive
                          ? 'lib/assets/icons/active.svg'
                          : 'lib/assets/icons/inactive.svg',
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
                          'Parking Spot: ${widget.parkingSpot ?? '-'}',
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
                  // Added padding on the right side
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
                                    color: _isActive
                                        ? const Color(0xFFADBBB9)
                                        : const Color(0xFFADBBB9)
                                            .withOpacity(0.5),
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    decoration: _isActive
                                        ? TextDecoration.none
                                        : TextDecoration.lineThrough,
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
              color: Colors.transparent, // Transparent material
              child: InkWell(
                onTap: () {
                  if (_isActive) {
                    _setInactive(); // Set to inactive if currently active
                  } else {
                    _setActive(); // Set to active if currently inactive
                  }
                  widget.onTap(); // Call the parent callback
                },
                splashColor: const Color(itemColorHighlightedTransparent),
                highlightColor: Colors.transparent, // No highlight color
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
