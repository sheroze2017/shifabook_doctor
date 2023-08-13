import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shifabook_doctor/views/Authentication/login_screen.dart';
import 'package:shifabook_doctor/views/doctor_info.dart';
import 'package:shifabook_doctor/views/update_screen.dart';

import '../Controller/user_authentication/login_controller.dart';
import '../views/home.dart';

class NavigationDrawer1 extends StatelessWidget {
  const NavigationDrawer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // color: Color.fromARGB(255, 209, 206, 206),
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffFBB97C), Color(0xffFC9535)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 40, 24, 0),
              child: Column(
                children: [
                  headerWidget(),
                  SizedBox(
                    height: 1.h,
                  ),
                  Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // DrawerItem(
                  //   name: 'People',
                  //   icon: Icons.people,
                  //   onPressed: () => onItemPressed(context, index: 0),
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  DrawerItem(
                      name: 'My Account',
                      icon: Icons.account_box_rounded,
                      onPressed: () => onItemPressed(context, index: 1)),
                  const SizedBox(
                    height: 30,
                  ),
                  // DrawerItem(
                  //     name: 'Chats',
                  //     icon: Icons.message_outlined,
                  //     onPressed: () => onItemPressed(context, index: 2)),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // DrawerItem(
                  //     name: 'Favourites',
                  //     icon: Icons.favorite_outline,
                  //     onPressed: () => onItemPressed(context, index: 3)),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  const Divider(
                    thickness: 1,
                    height: 10,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DrawerItem(
                      name: 'Setting',
                      icon: Icons.settings,
                      onPressed: () => onItemPressed(context, index: 2)),
                  const SizedBox(
                    height: 30,
                  ),
                  DrawerItem(
                      name: 'Log out',
                      icon: Icons.logout,
                      onPressed: () => onItemPressed(context, index: 3)),
                ],
              ),
            ),
          ),
          LoadingDialog()
        ]),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    // Navigator.pop(context);

    switch (index) {
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateScreen()));
        break;
      case 3:
        LoginController().logoutLoader.value = true;
        fun();
    }
  }

  fun() async {
    print('click');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshtoken = prefs.getString('refresh_Token');
    String? access_token = prefs.getString('access_Token');

    final body = {"refresh_token": refreshtoken.toString()};
    try {
      var url = Uri.parse('http://3.80.54.173:4005/api/v1/users/logout');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        prefs.clear();
        Get.to(SignIn());
        // Future.delayed(Duration(seconds: 2));
        print('clear data');
      } else {
        Future.delayed(Duration(seconds: 5))
            .then((value) => LoginController().logoutLoader.value = false);
      }
    } catch (error) {
      print(error);
      // LoginController().logoutLoader.value = false;
    } finally {
      //  LoginController().logoutLoader.value = false;
    }
  }

  Widget headerWidget() {
    const url =
        'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80';
    return Row(
      children: [
        CircleAvatar(
          radius: 30.sp,
          backgroundImage: NetworkImage(url),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shifabook',
                style: TextStyle(
                    fontSize: 20.sp, color: Colors.white, letterSpacing: 3)),
            // SizedBox(
            //   height: 10,
            // ),
            // Text('sheroze2017@gmail.com',
            //     style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        )
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.px,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.h,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17.sp, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => LoginController().logoutLoader.value
        ? AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),
          )
        : Container());
  }
}

void _navigateToNewScreen(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );

  // Simulate loading for 2 seconds
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/newScreen', (Route<dynamic> route) => false);
  });
}
