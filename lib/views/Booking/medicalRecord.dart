import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/Booking/createBooking.dart';

class MedicalRecored extends StatefulWidget {
  final int patid;
  MedicalRecored({required this.patid});

  @override
  State<MedicalRecored> createState() => _MedicalRecoredState();
}

class _MedicalRecoredState extends State<MedicalRecored> {
  final getbooking = Get.put(BookingList());
  bool checkdata = true;

  List<String> inactivestatus = [
    'Cancelled',
    'Rejected',
    'Refunded',
  ];
  List<String> activestatus = [
    'Awating Payment',
    'Pending Confirmation',
    'Rescheduled Request',
    'Rescheduling',
    'Cancellation Request'
  ];
  List<String> finishstatus = ['Confirmed and Scheduled', 'Completed'];
  List<String> locations = [
    'Dow University Ojha Campus',
    'Darul Sehat',
    'The Clinic 24/7'
  ];
  List<String> address = [
    "W4VQ+CMW, Gulzar-e-Hijri Gulshan-e-Iqbal, Karachi, Karachi City, Sindh, Pakistan",
    "St-19, KDA Scheme, Abul Asar Hafeez Jalandhari Rd, Block 15 Gulistan-e-Johar, Karachi, Karachi City, Sindh",
    "Plot SB 16, Block K North Nazimabad Town, Karachi, Karachi City, Sindh"
  ];
  @override
  void initState() {
    getbooking
        .getPastBooking(widget.patid)
        .then((value) => Future.delayed(Duration(seconds: 1), () {
              print('find');
              //print(getbooking.pastBookingData['data'].length);
              setState(() {
                checkdata = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History',
            style: TextStyle(color: Colors.black, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: checkdata
          ? Center(
              child: SpinKitWanderingCubes(
              color: Color.fromARGB(255, 241, 195, 86),
              size: 15.w,
            ))
          : Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        getbooking?.pastBookingData?['data']?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = getbooking?.pastBookingData?['data'];

                      if (data == null) {
                        return Container(); // Return an empty container if data is null
                      }

                      String datee = data[index]['appointment_date'] ?? '';
                      final String docname =
                          data[index]['booking_log_doctor']['full_name'] ?? '';
                      String remarks =
                          data[index]['doctor_OPDs']['remarks'] ?? '';

                      List<dynamic>? media =
                          data[index]['doctor_OPDs']['media'];

                      if (media != null && media.isNotEmpty) {
                        String imageUrl = media[0]['prescirptipon'] ?? '';

                        return Card(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Date: ' +
                                      (datee.length >= 10
                                          ? datee.substring(0, 10)
                                          : ''),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Doctor Name: ' + docname,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text('Remarks: ' + remarks),
                              ),
                              SizedBox(height: 20.0),
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                height: 70.h,
                                width: 100.w,
                              ),
                              Divider()
                            ],
                          ),
                        );
                      } else {
                        return Container(); // Return an empty container if media is null or empty
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }
}
