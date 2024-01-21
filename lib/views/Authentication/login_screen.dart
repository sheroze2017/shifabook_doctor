import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook_doctor/Controller/user_authentication/login_controller.dart';
import 'package:shifabook_doctor/views/home.dart';
import 'package:shifabook_doctor/views/Authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'form_screen.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "+923000000007");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");
  final LoginController LController = Get.put(LoginController());

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+92##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 25, 8, 8),
                    child: withEmailPassword(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/vector-doc2.jpg',
                scale: 5.5,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Login',
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              inputFormatters: [maskFormatter],
              focusNode: f1,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Phone No',
                hintText: '+923000000000',
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(90.0),
                    ),
                    borderSide: BorderSide(color: Colors.indigo, width: 2)),
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
                f1.unfocus();
                FocusScope.of(context).requestFocus(f2);
              },
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Phone Number';
                } else {
                  RegExp regex = RegExp(r'^\+923\d{9}$');

                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid phone number in the \nformat (+923000000000)';
                  } else {
                    return null;
                  }
                }
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
              //keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Password',
                contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  // borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[350],
                hintText: 'Password',
                hintStyle: GoogleFonts.lato(
                  color: Colors.black26,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onFieldSubmitted: (value) {
                f2.unfocus();
                FocusScope.of(context).requestFocus(f3);
              },
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) return 'Please enter the Password';
                return null;
              },
              obscureText: true,
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              width: 40.w,
              height: 6.h,
              child: ElevatedButton(
                focusNode: f3,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LController.login(
                        _emailController.text, _passwordController.text);
                    //_signInWithEmailAndPassword()
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.indigo[900],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Obx(() {
                  if (LController.isloading.value) {
                    return SpinKitWave(
                      color: Colors.white,
                      size: 8.w,
                    );
                  } else {
                    return Text(
                      "Submit",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                }),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () => Get.to(Register(),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 500)),
                      child: Text(
                        'Signup here',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

  void _signInWithEmailAndPassword() async {
    // try {
    //   final User user = (await _auth.signInWithEmailAndPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //  ))
    //       .user;
    //   if (!user.emailVerified) {
    //     await user.sendEmailVerification();
    //   }
    //   Navigator.of(context)
    //       .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    // } catch (e) {
    //   final snackBar = SnackBar(
    //     content: Row(
    //       children: [
    //         Icon(
    //           Icons.info_outline,
    //           color: Colors.white,
    //         ),
    //         Text(" There was a problem signing you in"),
    //       ],
    //     ),
    //   );
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
