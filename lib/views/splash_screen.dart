import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shifabook_doctor/views/Authentication/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animationController.forward();

    // Delay navigation to a new screen after 2 seconds
    Future.delayed(Duration(seconds: 5), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => SignIn()),
      // );
      Get.to(SignIn(), transition: Transition.circularReveal);
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
