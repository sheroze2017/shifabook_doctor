import 'dart:convert';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/Booking/bookinglog.dart';
import 'package:shifabook_doctor/views/doctor_info.dart';
import 'package:shifabook_doctor/views/set_Avail.dart';
import 'package:shifabook_doctor/views/update_screen.dart';

import '../Controller/doctorData/Availability.dart';
import '../components/appbar.dart';
import '../data/data.dart';
import '../model/speciality.dart';
import 'Booking/pendingConfirm.dart';

String selectedCategorie = "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["Adults", "Childrens", "Womens", "Mens"];
  final SwitchController _switchController = Get.put(SwitchController());
  late List<SpecialityModel> specialities;

  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> fullDoctorData =
        await jsonDecode(prefs.getString('DoctorFullData')!);
    var is_busy = fullDoctorData['is_active'];
    var on_leave = fullDoctorData['doctor_availability']['on_leave'];
    _switchController.isLeaveOn.value = on_leave;
    _switchController.isSwitchedOn.value = is_busy;

    print(fullDoctorData);
  }

  @override
  void initState() {
    // TODO: implement initState
    func();
    super.initState();

    specialities = getSpeciality();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer1(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 8),
            child: IconButton(
              icon: Icon(
                Icons.notification_important,
                size: 35,
                color: Colors.indigo[700],
              ),
              onPressed: () {
                // Open user profile page
                // Add your navigation logic here
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Doctor DashBoard",
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.8),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 231, 213, 162),
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              child: Text(
                                _switchController.isSwitchedOn.value
                                    ? ' Online '
                                    : ' Offline ',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ),
                          Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            value: _switchController.isSwitchedOn.value,
                            onChanged: (value) {
                              _switchController.toggleSwitch();
                              _switchController.updateonlinebusy();
                            },
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 231, 213, 162),
                                borderRadius:
                                    BorderRadius.circular(10), // Border radius
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1, // Border width
                                ),
                              ),
                              child: Text(
                                _switchController.isLeaveOn.value
                                    ? ' Available '
                                    : ' Busy ',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                          ),
                          Switch(
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            value: _switchController.isLeaveOn.value,
                            onChanged: (value) {
                              _switchController.toggleSwitch2();
                              _switchController.updateonlinebusy();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DoctorsTile(
                route: () {
                  Get.to(DoctorsInfo(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 400));
                },
                title: 'Profile',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Get.to(setAvailability(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 400));
                },
                title: 'Set Availaility',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Get.to(BookingPending(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 400));
                },
                title: 'Pending Approval',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Get.to(BookingLogs(),
                      transition: Transition.native,
                      duration: Duration(milliseconds: 450));
                },
                title: 'Change Status',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _HomePageState context;
  CategorieTile(
      {required this.categorie,
      required this.isSelected,
      required this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile(
      {required this.imgAssetPath,
      required this.speciality,
      required this.noOfDoctors,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            speciality,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "$noOfDoctors Doctors",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          Image.asset(
            imgAssetPath,
            height: 15.h,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}

class DoctorsTile extends StatelessWidget {
  final String title;
  Function route;

  DoctorsTile({super.key, required this.title, required this.route});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        route();
      },
      child: Container(
        height: 15.h,
        decoration: BoxDecoration(
            color: Color(0xffFFEEE0), borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/doctor_pic.png",
              height: 8.h,
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(color: Color(0xffFC9535), fontSize: 17),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
              decoration: BoxDecoration(
                  color: Color(0xffFBB97C),
                  borderRadius: BorderRadius.circular(13)),
              child: Text(
                "open",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
