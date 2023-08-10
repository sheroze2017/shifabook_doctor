import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorsInfo extends StatefulWidget {
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                          "Dr. Stefeni Albert",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        Text(
                          "Heart Speailist",
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: <Widget>[
                            IconTile(
                              backColor: Color(0xffFFECDD),
                              imgAssetPath: "assets/email.png",
                            ),
                            IconTile(
                              backColor: Color(0xffFEF2F0),
                              imgAssetPath: "assets/call.png",
                            ),
                            IconTile(
                              backColor: Color(0xffEBECEF),
                              imgAssetPath: "assets/video_call.png",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
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
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset("assets/mappin.png"),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Address",
                                style: TextStyle(
                                    color: Colors.black87.withOpacity(0.7),
                                    fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                  width: 20.w,
                                  child: Text(
                                    "House # 2, Road # 5, Green Road Dhanmondi, Dhaka, Bangladesh",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15.sp),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ],
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
                                padding: const EdgeInsets.only(left: 8, top: 8),
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
