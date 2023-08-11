import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shifabook_doctor/views/doctor_info.dart';
import 'package:shifabook_doctor/views/set_Avail.dart';

import '../data/data.dart';
import '../model/speciality.dart';

String selectedCategorie = "Adults";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["Adults", "Childrens", "Womens", "Mens"];

  late List<SpecialityModel> specialities;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    specialities = getSpeciality();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8),
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
      drawer: Drawer(child: Container() // Populate the Drawer in the next step.
          ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
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
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DoctorsInfo()));
                },
                title: 'Update Profile',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => setAvailability()));
                },
                title: 'Set Availaility',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DoctorsInfo()));
                },
                title: 'Payment Logs',
              ),
              SizedBox(
                height: 4.h,
              ),
              DoctorsTile(
                route: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DoctorsInfo()));
                },
                title: 'Profile History',
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
