import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/doctorData/update.dart';
import '../Controller/user_authentication/form_controller.dart';
import '../components/textfield.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DoctorController Dcontroller = Get.put(DoctorController());
  TextEditingController _expController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _onlinefeeController = TextEditingController();
  TextEditingController _onsitefeeController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _affiliationController = TextEditingController();
  List<dynamic> _selectedqualification = [];
  List<dynamic> _selectedexpertise = [];
  List<dynamic> _selectedexpertiseid = [];
  List<dynamic> _selectedaffiliation = [];
  List<dynamic> list = <String>['One', 'Two', 'Three', 'Four'];
  final List<String> items = [
    "Dermatologist",
    "Gynecologist",
    "Psychiatrist",
    "Urologist",
    "Child Specialist",
    "General Physician",
    "Eye Specialist"
  ];
  Map<String, dynamic> cityMap2 = {
    'karachi': 1,
    'lahore': 2,
    'islamabad': 3,
    'quetta': 4,
    'peshawar': 5,
  };
  late String selectedCountry;
  late String selectedState;
  String selectedCity = ''; // Selected city name
  int selectedCityId = 0; // Selected city ID
  String? selectedValue;
  var checkdata = true;
  func() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> fullDoctorData =
        await jsonDecode(prefs.getString('DoctorFullData')!);
    print(fullDoctorData);
    setState(() {
      selectedCityId = fullDoctorData['cities'][0]['id'];
      _nameController.text = fullDoctorData['full_name'];
      _selectedqualification = fullDoctorData['doctor_user']['qualification'];
      print(_selectedqualification);
      List<dynamic> expertise = fullDoctorData['categories'];
      for (var item in expertise) {
        _selectedexpertiseid.add(item['id']);
        _selectedexpertise.add(item['name']);
      }
      _selectedaffiliation = fullDoctorData['doctor_user']['affilation'];
      _expController.text =
          fullDoctorData['doctor_user']['years_of_experience'].toString();
      _onsitefeeController.text =
          fullDoctorData['doctor_user']['onsite_consultation_fee'].toString();
      _onlinefeeController.text =
          fullDoctorData['doctor_user']['online_consultation_fee'].toString();
      _ageController.text = fullDoctorData['age'].toString();
      _dobController.text = fullDoctorData['dob'].toString();
    });
  }

  bool check = false;
  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();
  @override
  void initState() {
    //availbility().updateAvailibility();
    // doctorProfileService().fetchAndStoreProfile();
    // landmark().fetchLandmarkNames(1);
    func();
    setState(() {
      checkdata = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checkdata
          ? Container()
          : Form(
              key: _formKey,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back)),
                        ],
                      ),

                      const Center(
                          child: Text(
                        'Update Doctor Detail',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text("Update Details",
                          style: GoogleFonts.lato(
                            letterSpacing: 4,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 6.h,
                        child: TextFormField(
                          focusNode: f1,
                          decoration: InputDecoration(
                            labelText: 'Qualification',
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(90.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2)),
                            filled: true,
                            fillColor: Colors.grey[350],
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {},
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                _selectedqualification.add(value.toString());
                                _qualificationController.clear();
                                f1.requestFocus();
                              }
                            });
                          },
                          inputFormatters: [],
                          controller: _qualificationController,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: _selectedqualification
                            .map(
                              (skill) => InputChip(
                                label: Text(skill),
                                onDeleted: () {
                                  setState(() {
                                    _selectedqualification.remove(skill);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          focusNode: f2,
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Icon(
                                Icons.list,
                                size: 16,
                                color: Colors.black,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Select Expertise',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {
                              if (value!.isNotEmpty &&
                                  !_selectedexpertise.contains(value)) {
                                _selectedexpertise.add(value.toString());
                                _selectedexpertiseid
                                    .add(items.indexOf(value) + 1);
                                _expertiseController.clear();
                                f2.requestFocus();
                              }
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 6.h,

                            /// width: ,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey,
                            ),
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: _selectedexpertise
                            .map(
                              (skill) => InputChip(
                                label: Text(skill),
                                onDeleted: () {
                                  setState(() {
                                    _selectedexpertise.remove(skill);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 6.h,
                        child: TextFormField(
                          focusNode: f3,
                          decoration: InputDecoration(
                            labelText: 'Affilation',
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(90.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.indigo, width: 2)),
                            filled: true,
                            fillColor: Colors.grey[350],
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            // Do nothing
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                _selectedaffiliation.add(value.toString());
                                _affiliationController.clear();
                                f3.requestFocus();
                              }
                            });
                          },
                          inputFormatters: [],
                          controller: _affiliationController,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Wrap(
                        spacing: 8.0,
                        children: _selectedaffiliation
                            .map(
                              (skill) => InputChip(
                                label: Text(skill),
                                onDeleted: () {
                                  setState(() {
                                    _selectedaffiliation.remove(skill);
                                  });
                                },
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomTextFormField(
                        focusNode: f4,
                        controller: _expController,
                        labeltext: 'Years experience',
                        onFieldSubmitted: (value) {
                          // FocusScope.of(context).requestFocus(f5);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Experience';
                          }
                          // Add any additional validation logic as needed
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomTextFormField(
                          focusNode: f5,
                          controller: _onsitefeeController,
                          hintText: 'Onsite Fees',
                          labeltext: 'Onsite Fees',
                          onFieldSubmitted: (value) {
                            //FocusScope.of(context).requestFocus(f6);
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the fees';
                            }
                            RegExp numericRegex = RegExp(r'^\d+$');
                            if (!numericRegex.hasMatch(value)) {
                              return 'Enter a valid Fees';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomTextFormField(
                          focusNode: f8,
                          controller: _onlinefeeController,
                          hintText: 'Online Fees',
                          labeltext: 'Online Fees',
                          onFieldSubmitted: (value) {
                            f8.unfocus();

                            FocusScope.of(context).requestFocus(f9);
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the fees';
                            }
                            // Use a regex pattern to check if the value consists only of digits
                            RegExp numericRegex = RegExp(r'^\d+$');
                            if (!numericRegex.hasMatch(value)) {
                              return 'Enter a valid Fees';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      // Container(
                      //   height: 6.h,
                      //   child: TextFormField(
                      //     focusNode: f9,
                      //     style: GoogleFonts.lato(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w800,
                      //     ),
                      //     onChanged: (value) {
                      //       print(value);
                      //       print(cityMap2.entries);
                      //       if (cityMap2.containsKey(
                      //           _locationController.text.toLowerCase())) {
                      //         print('find');
                      //         print(value);
                      //         selectedCityId =
                      //             cityMap2[_locationController.text.toLowerCase()]!;
                      //         //print('$cityName has a value of $cityValue');
                      //       } else {
                      //         // print('City not found in the map');
                      //       }
                      //     },
                      //     controller: _locationController,
                      //     decoration: InputDecoration(
                      //       hintText: 'City',
                      //       labelText: 'Location',
                      //       suffixIcon: IconButton(
                      //           icon: Icon(Icons.location_on),
                      //           onPressed: () async {
                      //             await controller.getCurrentLocation();
                      //             _locationController.text =
                      //                 await controller.currentLocation ?? '';
                      //             if (cityMap2.containsKey(
                      //                 _locationController.text.toLowerCase())) {
                      //               print('find');
                      //               selectedCityId = cityMap2[
                      //                   _locationController.text.toLowerCase()]!;
                      //             }
                      //           }),
                      //       contentPadding:
                      //           EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      //       border: const OutlineInputBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(90.0),
                      //           ),
                      //           borderSide:
                      //               BorderSide(color: Colors.indigo, width: 2)),
                      //       filled: true,
                      //       fillColor: Colors.grey[350],
                      //       hintStyle: GoogleFonts.lato(
                      //         color: Colors.black26,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //     ),
                      //     onFieldSubmitted: (value) {
                      //       f9.unfocus();
                      //       FocusScope.of(context).requestFocus(f10);
                      //     },
                      //     textInputAction: TextInputAction.next,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please enter the location';
                      //       } else if (selectedCityId == 0) {
                      //         return 'Please enter Valid location';
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      CustomTextFormField(
                        focusNode: f6,
                        labeltext: 'Age',
                        controller: _ageController,
                        hintText: 'Age',
                        onFieldSubmitted: (value) {
                          f6.unfocus();
                          // FocusScope.of(context).requestFocus(f11);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Age';
                          }
                          int? age = int.tryParse(value);
                          if (age == null || age < 1 || age > 100) {
                            return 'Please enter a valid age';
                          }
                          // Add any additional validation logic as needed
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomTextFormField(
                        focusNode: f7,
                        controller: _dobController,
                        hintText: 'YYYY-MM-DD',
                        labeltext: 'Date Of Birth',
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          f7.unfocus();
                          // FocusScope.of(context).requestFocus(f8);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Date of Birth';
                          } else {
                            final RegExp dateRegex = RegExp(
                                r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

                            if (!dateRegex.hasMatch(value)) {
                              return 'Please enter a valid date\nin the format YYYY-MM-DD';
                            }

                            // Additional validation logic if needed
                            return null;
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: SizedBox(
                            width: 40.w,
                            height: 5.h,
                            child: ElevatedButton(

                                // focusNode: f3,
                                onPressed: () async {
                                  print(_selectedaffiliation);
                                  if (_formKey.currentState!.validate()) {
                                    await UpdatePofile().updateDoctorProfile(
                                        _nameController.text.toString(),
                                        _ageController.text.toString(),
                                        _expController.text.toString(),
                                        _selectedqualification,
                                        _selectedexpertise,
                                        _selectedexpertiseid,
                                        _selectedaffiliation,
                                        selectedCityId);
                                    // await Dcontroller.createDoctor(
                                    //     _selectedGender,
                                    //     _nameController.text,
                                    //     _selectedqualification,
                                    //     _selectedexpertise,
                                    //     _selectedexpertiseid,
                                    //     _selectedaffiliation,
                                    //     _expController.text,
                                    //     _onsitefeeController.text,
                                    //     _onlinefeeController.text,
                                    //     selectedCityId,
                                    //     _ageController.text,
                                    //     _dobController.text);
                                  }
                                  // Get.to(HomePage());
                                },
                                // if (_formKey.currentState.validate()) {
                                //   showLoaderDialog(context);
                                //   _signInWithEmailAndPassword();
                                // }

                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.indigo[900],
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                // focusNode: f3,
                                child: Obx(() {
                                  if (Dcontroller.isloading.value) {
                                    return SpinKitWave(
                                      color: Colors.white,
                                      size: 6.w,
                                    );
                                  } else {
                                    return Text(
                                      "Update",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                }))),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
    );
  }
}
