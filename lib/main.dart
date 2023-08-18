import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifabook_doctor/views/Authentication/form_screen.dart';
import 'package:shifabook_doctor/views/home.dart';
import 'package:shifabook_doctor/views/Authentication/login_screen.dart';
import 'package:shifabook_doctor/views/Authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shifabook_doctor/views/set_Avail.dart';
import 'package:shifabook_doctor/views/splash_screen.dart';

import 'views/Authentication/otp_screen.dart';
import 'views/doctor_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Timer.periodic(Duration(seconds: 150), (timer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? refresh_token = prefs.getString('refresh_Token');
    String? mobile = prefs.getString('mobile');
    if (refresh_token != null && mobile != null) {
      final url = Uri.parse('http://3.80.54.173:4005/api/v1/users/token');

      final body = jsonEncode({
        "email": "{{email}}",
        "mobile": mobile,
        "refresh_token": refresh_token
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
  });

  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      );
    });
  }
}
