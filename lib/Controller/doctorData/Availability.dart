import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class availbility extends GetxController {
  final AvailabilityData = {};

  updateAvailibility(
      int id, List days, String starttime, String endtime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> availability =
        await jsonDecode(prefs.getString('DoctorAvailability')!);

    for (var day in days) {
      availability.add({
        "Day": day,
        "times": [
          {"start_time": starttime, "end_time": endtime}
        ],
        "landmark_id": id
      });
    }

    print(availability);
    String? access_token = await prefs.getString('access_Token');
    final body = {"availability": availability};
    String url = 'http://3.80.54.173:4005/api/v1/doctors/set-availability';
    final response = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $access_token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      prefs.setString('DoctorAvailability', jsonEncode(availability));
      Get.snackbar('Message', 'Updated');
    }
  }
}
