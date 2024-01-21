import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook_doctor/views/Booking/medicalRecord.dart';

import '../../controller/Booking/createBooking.dart';
import 'patientRecordUpload.dart';

class BookingLogs extends StatefulWidget {
  @override
  State<BookingLogs> createState() => _BookingLogsState();
}

class _BookingLogsState extends State<BookingLogs> {
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
        .getBooking()
        .then((value) => Future.delayed(Duration(seconds: 1), () {
              setState(() {
                checkdata = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings',
            style: TextStyle(color: Colors.black, letterSpacing: 3)),
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
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 230, 230),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes the position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text(
                              'Active Status', // Replace with your text code
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text(
                              'Completed', // Replace with your text code
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 2.h,
                              width: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text(
                              'Inactive Status', // Replace with your text code
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: Obx(
                    () => getbooking.isloading.value
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: getbooking.bookings.length,
                            itemBuilder: (context, index) {
                              String dateString =
                                  getbooking.bookings[index].scheduledAt;
                              DateTime dateTime = DateTime.parse(dateString);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0,
                                            3), // changes the position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    onTap: () {},
                                    trailing: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: (inactivestatus.contains(
                                                      getbooking.bookings[index]
                                                          .bookingStatus)
                                                  ? Colors.red
                                                  : finishstatus.contains(
                                                          getbooking
                                                              .bookings[index]
                                                              .bookingStatus)
                                                      ? Colors.green
                                                      : Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          height: 3.h,
                                          width: 3.h,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            await getbooking.getbookingdetails(
                                                getbooking.bookings[index].id);

                                            var detail = getbooking.bookingData;

                                            Get.dialog(
                                              AlertDialog(
                                                shape: Border.all(
                                                  color: Colors.black,
                                                ),
                                                title: Text('Booking Details'),
                                                content: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Location',
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      "${locations[detail['data']['landmark_id'] - 1]}\n${address[detail['data']['landmark_id'] - 1]}",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.grey,
                                                          letterSpacing: 1),
                                                    ),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Divider(),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Patient Details',
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      "${detail['data']['booking_log_patient']['full_name']}\nAge: ${detail['data']['booking_log_patient']['age']}\nDisease: ${detail['data']['booking_log_patient']['user_patient']['disease'].join(' ')}\nAllergies: ${detail['data']['booking_log_patient']['user_patient']['allergies'].join(' ')}\nWeight: ${detail['data']['booking_log_patient']['user_patient']['weight']}\nHeight: ${detail['data']['booking_log_patient']['user_patient']['height']}\nBloodType: ${detail['data']['booking_log_patient']['user_patient']['blood_type']}",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.grey,
                                                          letterSpacing: 1),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          //Get.back();
                                                        },
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Get.to(
                                                                MedicalRecored(
                                                                    patid: detail['data']['booking_log_patient']
                                                                            [
                                                                            'user_patient']
                                                                        [
                                                                        'patient_id']),
                                                                transition:
                                                                    Transition
                                                                        .native,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300));
                                                          },
                                                          style: ButtonStyle(
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    OutlinedBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0), // Adjust the radius as needed
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .red), // Red outline border color
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .white), // White background color
                                                            foregroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .red),
                                                          ),
                                                          child: const Text(
                                                            'Medical Records',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(),
                                                    SizedBox(
                                                      height: 3.h,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Booking Status',
                                                        style: TextStyle(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      "${detail['data']['booking_status']}",
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.grey,
                                                          letterSpacing: 1),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Close'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (detail['data'][
                                                              'booking_status'] ==
                                                          'Confirmed and Scheduled') {
                                                        bool
                                                            confirmStatusChange =
                                                            await showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Confirm Status Change'),
                                                              content: Text(
                                                                  'Are you sure you want to change the status?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false); // Return false if not confirmed
                                                                  },
                                                                  child: Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true); // Return true if confirmed
                                                                  },
                                                                  child: Text(
                                                                      'Confirm'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (confirmStatusChange ==
                                                            true) {
                                                          bool statuschange = await getbooking
                                                              .changeStatusToComplete(
                                                                  detail['data']
                                                                              [
                                                                              'booking_log_patient']
                                                                          [
                                                                          'user_patient']
                                                                      [
                                                                      'patient_id'],
                                                                  detail['data']
                                                                      ['id'],
                                                                  true);
                                                          if (statuschange) {
                                                            Get.to(
                                                                PatientRemark(
                                                                  patientId: detail['data']
                                                                              [
                                                                              'booking_log_patient']
                                                                          [
                                                                          'user_patient']
                                                                      [
                                                                      'patient_id'],
                                                                  bookingId:
                                                                      detail['data']
                                                                          [
                                                                          'id'],
                                                                ),
                                                                transition:
                                                                    Transition
                                                                        .native);
                                                          } else {}
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      detail['data'][
                                                                  'booking_status'] ==
                                                              'Confirmed and Scheduled'
                                                          ? 'Change Status'
                                                          : detail['data'][
                                                              'booking_status'],
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Details',
                                            style: TextStyle(
                                                color: (inactivestatus.contains(
                                                        getbooking
                                                            .bookings[index]
                                                            .bookingStatus)
                                                    ? Colors.red
                                                    : finishstatus.contains(
                                                            getbooking
                                                                .bookings[index]
                                                                .bookingStatus)
                                                        ? Colors.green
                                                        : Colors.blue),
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      'Status: ${getbooking.bookings[index].bookingStatus}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Patient Name: ${getbooking.bookings[index].patientfullname}\nScheduled At: ${dateTime.day}-${dateTime.month}-${dateTime.year} \nTime: ${dateTime.hour}-${dateTime.minute} \nLocation: ${getbooking.bookings[index].landmarkName}',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ]),
            ),
    );
  }
}
