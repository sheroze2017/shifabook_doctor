import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:time_range/time_range.dart';

import '../Controller/doctorData/Availability.dart';
import '../Controller/doctorData/doctorInfo.dart';
import '../Controller/doctorData/landmark.dart';
import '../components/availdailog.dart';
import '../components/searchWidget.dart';

class setAvailability extends StatefulWidget {
  const setAvailability({super.key});

  @override
  State<setAvailability> createState() => _setAvailabilityState();
}

class _setAvailabilityState extends State<setAvailability> {
  bool checkdata = true;
  List<dynamic> location = [
    "Dow University Ojha Campus",
    "Darul Sehat",
    "The Clinic 24/7"
  ];
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    print('g');
    //availbility().updateAvailibility();
    // doctorProfileService().fetchAndStoreProfile();
    // landmark().fetchLandmarkNames(1);
    setState(() {
      checkdata = false;
    });
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checkdata
          ? Container()
          : Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  const Center(
                    child: Text(
                      'Availability',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("Set Your Availability",
                      style: GoogleFonts.lato(
                        letterSpacing: 4,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //  print(landmark().location);
                      // Show the CustomDialog and get the selected values
                      List<dynamic>? selectedValues = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog();
                        },
                      );
                      if (selectedValues != null) {
                        // Print the selected values or use them as you wish
                        print(
                            'Selected date: ${selectedValues[0]}, start time: ${selectedValues[1]}, end time: ${selectedValues[2]}, location: ${selectedValues[3]}');
                      }
                    },
                    child: Text('Add Location'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     print(landmark().location);
                  //     int selectedLocationId = await showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return SearchableDialog();
                  //       },
                  //     );
                  //     if (selectedLocationId != null) {
                  //       print('Selected Location ID: $selectedLocationId');
                  //     }
                  //   },
                  //   child: Text('Add Location'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Opening Times',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TimeRange(
                    fromTitle: const Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    toTitle: const Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //  titlePadding: leftPadding,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    activeTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                    borderColor: Colors.black,
                    activeBorderColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    activeBackgroundColor: Colors.black,
                    firstTime: const TimeOfDay(hour: 8, minute: 00),
                    lastTime: const TimeOfDay(hour: 20, minute: 00),
                    initialRange: _timeRange,
                    timeStep: 30,
                    timeBlock: 30,
                    onRangeCompleted: (range) =>
                        setState(() => _timeRange = range),
                    onFirstTimeSelected: (startHour) {},
                  ),
                ]),
              ),
            ),
    );
  }

  Future<List<String>> fetchLandmarkNames(int cityId) async {
    final baseUrl = "http://3.80.54.173:4005"; // Replace with your base URL
    final apiUrl = "$baseUrl/api/v1/location/landmark?city_id=$cityId";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final landmarks = jsonData['data'] as List<dynamic>;
        final landmarkNames =
            landmarks.map((landmark) => landmark['name'] as String).toList();
        return landmarkNames;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
