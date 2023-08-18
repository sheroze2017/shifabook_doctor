import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:time_range/time_range.dart';

import '../Controller/doctorData/Availability.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // Declare variables to store the selected date, time and location
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  // LocationResult? _selectedLocation;
  List<String> locations = [
    'Dow University Ojha Campus',
    'Darul Sehat',
    'The Clinic 24/7'
  ];
  TextEditingController _searchController = TextEditingController();
  final List<DayInWeek> _days = [
    DayInWeek("M", dayKey: "Monday"),
    DayInWeek("Tu", dayKey: "Tuesday"),
    DayInWeek("W", dayKey: "Wednesday"),
    DayInWeek("Th", dayKey: "Thursday"),
    DayInWeek("F", dayKey: "Friday"),
    DayInWeek(
      "Sat",
      dayKey: "Saturday",
    ),
    DayInWeek(
      "Sun",
      dayKey: "Sunday",
    ),
  ];
  List<String> day = [];
  String selectedOption = '';
  TimeRangeResult? _timeRange;

  List<String> loca = [];
  List<String> days = [];
  List<String> time = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Set Availability')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(labelText: 'Select an option'),
            ),
            suggestionsCallback: (pattern) {
              return locations.where((option) =>
                  option.toLowerCase().contains(pattern.toLowerCase()));
            },
            itemBuilder: (context, suggestion) {
              return ListTile(title: Text(suggestion));
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                selectedOption = suggestion;
              });
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please select an option';
              }
              return null;
            },
          ),
          Text(
              'Location ${selectedOption == '' ? 'Not Selected' : '${selectedOption}'}'),
          Divider(),
          SelectWeekDays(
            daysBorderColor: Colors.black,
            backgroundColor: const Color.fromARGB(255, 64, 63, 63),
            fontSize: 8,
            fontWeight: FontWeight.w500,
            days: _days,
            onSelect: (values) {
              print(values);
              setState(() {
                day = values;
              });
            },
          ),
          Divider(),
          TimeRange(
            fromTitle: const Text(
              'FROM',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            toTitle: const Text(
              'TO',
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            activeTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
            borderColor: Colors.black,
            activeBorderColor: Colors.black,
            backgroundColor: Colors.transparent,
            activeBackgroundColor: Colors.black,
            firstTime: TimeOfDay(hour: 7, minute: 00),
            lastTime: TimeOfDay(hour: 23, minute: 00),
            initialRange: _timeRange,
            timeStep: 60,
            timeBlock: 60,
            onRangeCompleted: (range) => setState(() {
              _timeRange = range;
              print(_timeRange!.start.period);
              print(_timeRange!.end.period);
            }),
            onFirstTimeSelected: (lastTime) {
              print(lastTime);
            },
          ),
        ],
      ),
      actions: [
        // Use a FlatButton to close the dialog and return the values
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xffFC9535), // Text color
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Border radius
              )),
          onPressed: () async {
            if (selectedOption.toString() == '' ||
                day.isEmpty ||
                _timeRange!.start.hour == null ||
                _timeRange!.end.hour == null) {
              Get.snackbar('Error', 'Invalid Data');
            } else {
              String statTime = await _timeRange!.start.hour.toString() +
                  ':' +
                  _timeRange!.start.minute.toString();
              String endTime = await _timeRange!.end.hour.toString() +
                  ':' +
                  _timeRange!.end.minute.toString();
              print(statTime);
              print(endTime);
              print(day);
              print(selectedOption);
              availbility().updateAvailibility(
                  locations.indexOf(selectedOption) + 1,
                  day,
                  statTime,
                  endTime,
                  _timeRange!);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
