import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/Authentication/login_screen.dart';
import 'package:shifabook_doctor/views/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('refresh_Token');
    if (token != null) {
      await accessFunc();
      Get.offAll(HomePage(),
          transition: Transition.fade, duration: Duration(milliseconds: 500));
    } else {
      Get.offAll(SignIn(),
          transition: Transition.fade, duration: Duration(milliseconds: 500));
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animationController.forward();

    // Delay navigation to a new screen after 2 seconds
    Future.delayed(Duration(seconds: 3), () {
      func();
      // Get.to(SignIn(), transition: Transition.circularReveal);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey,
            end: Colors.grey.withOpacity(0.5),
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.grey.withOpacity(0.5),
            end: Colors.grey,
          ),
        ),
      ],
    ).animate(_animationController);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          gradientAnimation.value!,
                          gradientAnimation.value!,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'SHIFABOOK',
                      style: TextStyle(
                        fontSize: 24.sp,
                        wordSpacing: 4,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(82, 172, 245, 1),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 5.h),
              Lottie.asset(
                'assets/141984-dna-doctor.json',
                width: 80.w,
                height: 80.w,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

accessFunc() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? refreshToken = prefs.getString('refresh_Token');
  String? mobile = prefs.getString('mobile');
  if (refreshToken != null && mobile != null) {
    final url = Uri.parse('http://3.80.54.173:4005/api/v1/users/token');

    final body = jsonEncode({
      "email": "{{email}}",
      "mobile": mobile,
      "refresh_token": refreshToken
    });

    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        //print(jsonDecode(response.body)['data']['access_token']);
        // Success
        print('API hit successful');
        String accessToken =
            await jsonDecode(response.body)['data']['access_token'];
        await prefs.setString('access_Token', accessToken.toString());
        print(prefs.getString('access_Token'));
        // await UserProfileService().fetchAndStoreProfile();
      } else {
        // Handle error
        print('Failed to hit the API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error hitting the API: $e');
    }
  } else {
    print('print no data yet');
  }
}
