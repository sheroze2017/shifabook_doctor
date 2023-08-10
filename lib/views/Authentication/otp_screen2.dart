import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controller/user_authentication/otp_controller.dart';

class Otp extends StatefulWidget {
  // const Otp({Key key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

final controller = Get.put(OTPController());
final TextEditingController _pincontroller = TextEditingController();

final List? arguments = Get.arguments;
//final String phrase = arguments[0] ;
final String number = (arguments?[0] ?? '') as String;

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 33.w,
                    height: 33.w,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/doc.png',
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Enter your OTP code number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     _textFieldOTP(
                        //       first: true,
                        //       last: false,
                        //       onChanged: (value) {
                        //         otp = value;
                        //       },
                        //     ),
                        //     _textFieldOTP(
                        //       first: false,
                        //       last: false,
                        //       onChanged: (value) {
                        //         if (value.isEmpty) {
                        //           otp = otp.substring(0, otp.length - 1);
                        //         } else {
                        //           otp += value;
                        //           print('OTP: $otp');
                        //         }
                        //       },
                        //     ),
                        //     _textFieldOTP(
                        //       first: false,
                        //       last: false,
                        //       onChanged: (value) {
                        //         if (value.isEmpty) {
                        //           otp = otp.substring(0, otp.length - 1);
                        //         } else {
                        //           otp += value;
                        //           print('OTP: $otp');
                        //         }
                        //       },
                        //     ),
                        //     _textFieldOTP(
                        //       first: false,
                        //       last: true,
                        //       onChanged: (value) {
                        //         if (value.isEmpty) {
                        //           otp = otp.substring(0, otp.length - 1);
                        //         } else {
                        //           otp += value;
                        //           print('OTP: $otp');
                        //         }
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // // SizedBox(
                        //   height: 5.h,
                        // ),

                        OtpTextField(
                          fieldWidth: 10.w,

                          textStyle: TextStyle(fontSize: 10),
                          numberOfFields: 5,
                          borderColor: Colors.indigo,
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            print(code);
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode) {
                            print(verificationCode);
                            _pincontroller.text = verificationCode;
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         title: Text("Verification Code"),
                            //         content: Text(
                            //             'Code entered is $verificationCode'),
                            //       );
                            //     });
                          }, // end onSubmit
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              print(number);
                              print(_pincontroller.text);
                              await controller.verifyUser(
                                  number, _pincontroller.text);
                              // Get.to(SignIn());
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 48, 63, 159)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Verify',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Didn't you receive any code?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Resend New Code",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // String otp = '';

  // Widget _textFieldOTP({
  //   required bool first,
  //   last,
  //   required Function(String) onChanged,
  // }) {
  //   return SizedBox(
  //     height: 10.h,
  //     width: 14.w,
  //     child: AspectRatio(
  //       aspectRatio: 1.0,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: onChanged,
  //         // onChanged: (value) {
  //         //   if (value.length == 1 && last == false) {
  //         //     FocusScope.of(context).nextFocus();
  //         //     otp.add(value);
  //         //   }
  //         //   if (value.length == 0 && first == false) {
  //         //     FocusScope.of(context).previousFocus();
  //         //     otp.removeLast();
  //         //   }
  //         // },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: Colors.black12),
  //               borderRadius: BorderRadius.circular(12)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(width: 2, color: Colors.purple),
  //               borderRadius: BorderRadius.circular(12)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
