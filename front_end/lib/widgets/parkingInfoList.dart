import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end/pages/reservationPage.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
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
  final int? initialHours;
  final int? initialMinutes;
  final int? initialSeconds;
  final int activeCars; 
  final int totalSpots; 

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
        if (widget.initialHours == -1 ||
            widget.initialMinutes == -1 ||
            widget.initialSeconds == -1) {
          _formattedTime = 'Inactive';
        } else {
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

  void _navigateToDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationPage(
          parkingId: widget.parkingId,
          parkingSpot: widget.parkingSpot,
        ),
      ),
    );
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
                      widget.initialHours == -1
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
                              '${widget.activeCars}/${widget.totalSpots}', // Display active cars/total spots
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
                                    color: widget.initialHours == -1
                                        ? const Color(0xFFADBBB9)
                                            .withOpacity(0.5)
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
                onTap: _navigateToDetailsPage, // Navigate to details page
                splashColor: const Color(itemColorHighlightedTransparent),
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
