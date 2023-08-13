import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

  List<String> locations = [
    'Dow University Ojha Campus',
    'Darul Sehat',
    'The Clinic 24/7'
  ];
  final List<Map<String, dynamic>> availabilityData = [
    {
      "Day": "Monday",
      "times": [
        {"end_time": "10:00pm", "start_time": "7:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Monday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Tuesday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Wednesday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Thursday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Friday",
      "times": [
        {"end_time": "10:00pm", "start_time": "6:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Saturday",
      "times": [
        {"end_time": "6:00pm", "start_time": "1:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Sunday",
      "times": [
        {"end_time": "6:00pm", "start_time": "1:00pm"}
      ],
      "landmark_id": 2
    },
    {
      "Day": "Wednesday",
      "times": [
        {"start_time": "0:0", "end_time": "6:0"}
      ],
      "landmark_id": 1
    }
  ];
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;
  List<dynamic> availability = [];
  fun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> avail = jsonDecode(prefs.getString('DoctorAvailability')!);
    setState(() {
      availability = avail;
      checkdata = false;
    });
  }

  @override
  void initState() {
    //availbility().updateAvailibility();
    // doctorProfileService().fetchAndStoreProfile();
    // landmark().fetchLandmarkNames(1);
    fun();
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
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back)),
                      SizedBox(
                        width: 18.w,
                      ),
                      const Text(
                        'Availability',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                    ],
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
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffFC9535), // Text color
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        )), // Elevation (shadow) of the button

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
                        setState(() {});
                        // Print the selected values or use them as you wish
                        print(
                            'Selected date: ${selectedValues[0]}, start time: ${selectedValues[1]}, end time: ${selectedValues[2]}, location: ${selectedValues[3]}');
                      }
                    },
                    child: Text('Add Location'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Your Times',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: availability.length,
                      itemBuilder: (context, index) {
                        final availabilit = availability[index];
                        final day = availabilit['Day'];
                        final times = availabilit['times'];
                        final landmarkId = availabilit['landmark_id'];

                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          trailing: InkWell(
                            onTap: () async {
                              await availability.removeAt(index);
                              setState(() {
                                availability = availability;

                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                // (prefs.setString('DoctorAvailability',
                                //     jsonEncode(availability)));
                              });
                              availbility().updateAvailibility2(availability);
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          title: Text('Day: $day'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('Location: ${locations[landmarkId - 1]}'),
                              Text(
                                  'Times: ${times[0]['start_time']} - ${times[0]['end_time']}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  //       title: Text('Day: $day'),
                  //       subtitle: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text('Landmark ID: $landmarkId'),
                  //           Text(
                  //               'Times: ${times[0]['start_time']} - ${times[0]['end_time']}'),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
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
