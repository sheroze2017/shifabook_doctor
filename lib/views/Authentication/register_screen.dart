import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shifabook_doctor/Controller/user_authentication/signup_controller.dart';
import 'package:shifabook_doctor/views/Authentication/form_screen.dart';
import 'package:shifabook_doctor/views/Authentication/otp_screen.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();
  final SignupController SController = Get.put(SignupController());

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();

  late bool _isSuccess;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  var maskFormatter = new MaskTextInputFormatter(
      mask: '+92##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 3.h,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 28, left: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Center(
                          child: Image.asset(
                            'assets/414-bg.png',
                            scale: 4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Sign up',
                        style: GoogleFonts.lato(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        focusNode: f1,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _displayName,
                        decoration: InputDecoration(
                          labelText: 'Full Name',

                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.indigo, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          //hintText: 'Email',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onTap: () {
                          _displayName.text = 'Dr ';
                        },
                        onFieldSubmitted: (value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter the Name';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        focusNode: f2,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',

                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.indigo, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          //hintText: 'Email',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f2.unfocus();
                          if (_passwordController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(f3);
                          }
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Email';
                          } else {
                            // Define a regex pattern to validate email addresses
                            RegExp regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        focusNode: f3,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [maskFormatter],
                        controller: _mobileNo,
                        decoration: InputDecoration(
                          labelText: 'Phone No',
                          hintText: '+923000000000',
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.indigo, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          //hintText: 'Email',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f3.unfocus();
                          FocusScope.of(context).requestFocus(f4);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone No';
                          } else {
                            // Define a regex pattern to match the desired format: +923 followed by 9 digits
                            RegExp regex = RegExp(r'^\+923\d{9}$');

                            if (!regex.hasMatch(value)) {
                              return 'Please enter a valid phone number in the \nformat (+923000000000)';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        focusNode: f4,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        //keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.indigo, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          labelText: 'Password',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f4.unfocus();
                          if (_passwordConfirmController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(f5);
                          }
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Password';
                          } else if (value.length < 6) {
                            return 'Password must be at least\n6 characters long';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        focusNode: f5,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(90.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.indigo, width: 2)),
                          filled: true,
                          fillColor: Colors.grey[350],
                          labelText: 'Confirm Password',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          f4.unfocus();
                        },
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Password';
                          } else if (value
                                  .compareTo(_passwordController.text) !=
                              0) {
                            return 'Password not Matching';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: SizedBox(
                              width: 33.w,
                              height: 50,
                              child: Obx(() {
                                if (SController.isloading.value == true) {
                                  return SpinKitFadingCube(
                                    color: Colors.indigo[900],
                                    size: 10.w,
                                  );
                                } else {
                                  return ElevatedButton(
                                    child: Text(
                                      "Sign Up",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Get.to(otpmobile());

                                      if (_formKey.currentState!.validate()) {
                                        //showLoaderDialog(context);
                                        SController.signup(
                                            _displayName.text,
                                            _passwordController.text,
                                            _mobileNo.text);
                                        // Get.to(formScreen());
                                        // _registerAccount();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.indigo[900],
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                  );
                                }
                              }))),
                      Container(
                        padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Divider(
                          thickness: 1.5,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.lato(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: () => _pushPage(context, SignIn()),
                                child: Text(
                                  'Sign in',
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    color: Colors.indigo[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  // Widget _signUp() {
  //   return
  // }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(f2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email already Exists",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _registerAccount() async {
    // User user;
    // UserCredential credential;

    // try {
    //   credential = await _auth.createUserWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    // } catch (error) {
    //   if (error.toString().compareTo(
    //           '[firebase_auth/email-already-in-use] The email address is already in use by another account.') ==
    //       0) {
    //     showAlertDialog(context);
    //     print(
    //         "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    //     print(user);
    //   }
    // }
    // user = credential.user;

    // if (user != null) {
    //   if (!user.emailVerified) {
    //     await user.sendEmailVerification();
    //   }
    //   await user.updateProfile(displayName: _displayName.text);

    //   FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    //     'name': _displayName.text,
    //     'birthDate': null,
    //     'email': user.email,
    //     'phone': null,
    //     'bio': null,
    //     'city': null,
    //   }, SetOptions(merge: true));

    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    // } else {
    //   _isSuccess = false;
    // }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
