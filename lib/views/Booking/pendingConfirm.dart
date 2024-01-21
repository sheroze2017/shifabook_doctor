import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controller/Booking/createBooking.dart';

class BookingPending extends StatefulWidget {
  @override
  State<BookingPending> createState() => _BookingPendingState();
}

class _BookingPendingState extends State<BookingPending> {
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
        title: const Text('Pending Confirmation',
            style: TextStyle(color: Colors.black, letterSpacing: 1)),
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
                              if (getbooking.bookings[index].bookingStatus ==
                                  'Pending Confirmation') {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: 15.h,
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
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Confirm Booking'),
                                              content: Text(
                                                  'Press Confirm to Schedule Meeting'),
                                              actions: [
                                                Obx(() {
                                                  if (getbooking
                                                      .isloadig2.value) {
                                                    return TextButton(
                                                      onPressed: () async {
                                                        await getbooking
                                                            .bookingconfirmation(
                                                                getbooking
                                                                    .bookings[
                                                                        index]
                                                                    .id);

                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Confirm',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    );
                                                  } else {
                                                    return SpinKitWave(
                                                      size: 7.w,
                                                      color: Colors.green,
                                                    );
                                                  }
                                                }),
                                                TextButton(
                                                  onPressed: () {
                                                    // Cancel the action
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      trailing: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
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
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            height: 3.h,
                                            width: 3.h,
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () async {
                                              // await getbooking.getbookingdetails(
                                              //     getbooking.bookings[index].id);

                                              // Get.dialog(
                                              //   AlertDialog(
                                              //     title: Text('Booking Details'),
                                              //     content: Obx(() {
                                              //       final bookingData2 =
                                              //           getbooking.bookingData;
                                              //       return bookingData2 != null
                                              //           ? Column(
                                              //               children: [
                                              //                 Text(bookingData2[
                                              //                             'data'][
                                              //                         'booking_log_doctor']
                                              //                     ['full_name']),
                                              //               ],
                                              //             )
                                              //           : CircularProgressIndicator();
                                              //     }),
                                              //     actions: [
                                              //       TextButton(
                                              //         onPressed: () {
                                              //           Get.back();
                                              //         },
                                              //         child: Text('Close'),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // );
                                            },
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  color: (inactivestatus
                                                          .contains(getbooking
                                                              .bookings[index]
                                                              .bookingStatus)
                                                      ? Colors.red
                                                      : finishstatus.contains(
                                                              getbooking
                                                                  .bookings[
                                                                      index]
                                                                  .bookingStatus)
                                                          ? Colors.green
                                                          : Colors.blue),
                                                  fontSize: 15.sp),
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
                                        'Patient Name: ${getbooking.bookings[index].patientfullname}\nScheduled At: ${dateTime.day}-${dateTime.month}-${dateTime.year} \nTime: ${dateTime.hour}-${dateTime.minute}\nLocation: ${getbooking.bookings[index].landmarkName}',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                  ),
                ),
              ]),
            ),
    );
  }
}
