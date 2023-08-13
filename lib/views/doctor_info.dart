import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/set_Avail.dart';

import 'update_screen.dart';

class DoctorsInfo extends StatefulWidget {
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  Map<String, dynamic> doctordata = {};
  List<dynamic> _selectedexpertise = [];
  List<dynamic> _selectedexpertiseid = [];
  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> fullDoctorData =
        await jsonDecode(prefs.getString('DoctorFullData')!);
    setState(() {
      doctordata = fullDoctorData;
      List<dynamic> expertise = fullDoctorData['categories'];
      for (var item in expertise) {
        _selectedexpertiseid.add(item['id']);
        _selectedexpertise.add(item['name']);
      }
      //   _selectedqualification = fullDoctorData['doctor_user']['qualification'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    func();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8),
          child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // iconTheme: const IconThemeData(color: Colors.black87),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    "assets/doctor_pic2.png",
                    height: 22.h,
                    width: 22.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 60.w,
                    height: 22.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${doctordata['full_name']}",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Text(
                          "${_selectedexpertise.join(' ')}",
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "Qualification",
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                "${doctordata['doctor_user']['qualification'].join(' ')}",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Affilation",
                style: TextStyle(fontSize: 18.sp),
              ),
              Text(
                "${doctordata['doctor_user']['affilation'].join(' ')}",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    "Onsite Fees  ",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    "${doctordata['doctor_user']['onsite_consultation_fee']}",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Online Fees  ",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  Text(
                    "${doctordata['doctor_user']['online_consultation_fee']}",
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Dr. Stefeni Albert is a cardiologist in Nashville & affiliated with multiple hospitals in the  area.He received his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
                style: TextStyle(color: Colors.grey, fontSize: 15.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffFC9535), // Text color
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius
                        )), // Elevation (shadow) of the button

                    onPressed: () {
                      Get.to(const UpdateScreen());
                    },
                    child: const Text('Update Profile'),
                  ),
                ),
              ),
              Text(
                "Activity",
                style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(const setAvailability()),
                        child: Container(
                          height: 20.h,
                          width: 18.h,
                          decoration: BoxDecoration(
                              color: Color(0xffFBB97C),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFCCA9B),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Image.asset("assets/list.png")),
                              SizedBox(
                                width: 3.w,
                              ),
                              SizedBox(
                                child: Text(
                                  "List Of Schedule",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.h,
                    ),
                    Expanded(
                      child: Container(
                        height: 20.h,
                        width: 18.h,
                        decoration: BoxDecoration(
                            color: Color(0xffA5A5A5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 8, top: 8),
                                decoration: BoxDecoration(
                                    color: Color(0xffBBBBBB),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Image.asset("assets/list.png")),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Doctor's Daily Post",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({required this.imgAssetPath, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 10.w,
        width: 10.w,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 10.w,
        ),
      ),
    );
  }
}
