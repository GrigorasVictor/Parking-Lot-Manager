import 'package:flutter/material.dart';

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
  State<ParkingInfoList> createState() => _ParkingInfoListState();
}

class _ParkingInfoListState extends State<ParkingInfoList> {
  final String font = 'Inter';
  final double iconSize = 50;

  late final String parkingIdText = 'Parking Lot #${widget.parkingId}';
  late final String parkingSpotText = 'Parking Spot: ${widget.parkingSpot}';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget
            .onTap, // TODO optional : probabil animatie sau ceva sa arate frumos cand apas
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 8,
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: iconSize,
                            width: iconSize,
                            child: Image.asset('lib/assets/icons/active.png'),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(parkingIdText,
                                  style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)),
                              Text(parkingSpotText,
                                  style: const TextStyle(
                                      color: Color(0xFFADBBB9),
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parkingIdText,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      parkingSpotText,
                                      style: const TextStyle(
                                        color: Color(0xFFADBBB9),
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
