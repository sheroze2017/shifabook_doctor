import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shifabook_doctor/Controller/user_authentication/form_controller.dart';
import 'package:shifabook_doctor/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/Location/locationController.dart';

class formScreen extends StatefulWidget {
  @override
  State<formScreen> createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DoctorController Dcontroller = Get.put(DoctorController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _onlinefeeController = TextEditingController();
  final TextEditingController _onsitefeeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityIdController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _yovdController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _affiliationController = TextEditingController();
  final TextEditingController _aadController = TextEditingController();

  List<String> _selectedqualification = [];
  List<String> _selectedexpertise = [];
  List<int> _selectedexpertiseid = [];
  List<String> _selectedaffiliation = [];
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  final List<String> items = [
    "Dermatologist",
    "Gynecologist",
    "Psychiatrist",
    "Urologist",
    "Child Specialist",
    "General Physician",
    "Eye Specialist"
  ];
  List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Quetta',
    'Peshawar',
  ];
  late String selectedCountry;
  late String selectedState;
  late String _selectedGender = 'male';

  FocusNode f1 = new FocusNode();
  FocusNode f2 = new FocusNode();
  FocusNode f3 = new FocusNode();
  FocusNode f4 = new FocusNode();
  FocusNode f5 = new FocusNode();
  FocusNode f6 = new FocusNode();
  FocusNode f7 = new FocusNode();
  FocusNode f8 = new FocusNode();
  FocusNode f9 = new FocusNode();
  FocusNode f10 = new FocusNode();
  FocusNode f11 = new FocusNode();
  FocusNode f12 = new FocusNode();
  String? selectedCity; // Selected city name
  int selectedCityId = 0; // Selected city ID

  String? selectedValue;
  //final controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                    child: Text(
                  'Doctor Detail',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3),
                )),
                SizedBox(
                  height: 2.h,
                ),
                Text("Enter your details to proceed",
                    style: GoogleFonts.lato(
                      letterSpacing: 4,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      //focusNode: f3,
                      onPressed: () {
                        setState(() {
                          _selectedGender = 'male';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedGender == 'male'
                            ? Colors.blue
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        'Male',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedGender = 'female';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedGender == 'female'
                            ? Colors.pink
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        'Female',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  focusNode: f1,
                  controller: _nameController,
                  hintText: 'LicenseNo',
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(f3);
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the licenseNo';
                    }
                    // Add any additional validation logic as needed
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 6.h,
                  child: TextFormField(
                    focusNode: f3,
                    decoration: InputDecoration(
                      labelText: 'Qualification',
                      hintText: 'MBBS,FCPS,FCPHS',
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
                          _selectedqualification.add(value.toString());
                          _qualificationController.clear();
                          f3.requestFocus();
                        }
                      });
                      // FocusScope.of(context).requestFocus(f9)
                      ;
                    },
                    inputFormatters: [],
                    controller: _qualificationController,
                    // controller: TextEditingController(
                    //   text: _selectedSkills.join(', '),
                    // ),
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
                    focusNode: f4,
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
                        if (value!.isNotEmpty) {
                          _selectedexpertise.add(value.toString());
                          _selectedexpertiseid.add(items.indexOf(value) + 1);
                          _expertiseController.clear();
                          f4.requestFocus();
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
                        thumbVisibility: MaterialStateProperty.all<bool>(true),
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
                Container(
                  height: 6.h,
                  child: TextFormField(
                    focusNode: f5,
                    decoration: InputDecoration(
                      labelText: 'Affilation',
                      hintText: 'AghaKhan ,  Iman Clinic',
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
                          f5.requestFocus();
                        }
                      });
                      // FocusScope.of(context).requestFocus(f9)
                      ;
                    },
                    inputFormatters: [],
                    controller: _affiliationController,
                    // controller: TextEditingController(
                    //   text: _selectedSkills.join(', '),
                    // ),
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
                  focusNode: f6,
                  controller: _expController,
                  labeltext: 'Years eg: 1',
                  hintText: 'Experience',
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(f7);
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
                    focusNode: f7,
                    controller: _onsitefeeController,
                    hintText: 'Onsite Fees',
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(f8);
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
                Container(
                    height: 6.h,
                    width: 80.h,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      hint: Text('', style: TextStyle(color: Colors.black)),
                      value: selectedCity,
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value.toString();
                          selectedCityId = cities.indexOf(value.toString()) + 1;
                          print(selectedCityId);
                        });
                      },
                      items:
                          cities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  focusNode: f10,
                  controller: _ageController,
                  hintText: 'Age',
                  onFieldSubmitted: (value) {
                    f10.unfocus();
                    FocusScope.of(context).requestFocus(f11);
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
                  focusNode: f11,
                  controller: _dobController,
                  hintText: 'YYYY-MM-DD',
                  labeltext: 'Date Of Birth',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    f11.unfocus();
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
                            // if (_formKey.currentState!.validate()) {
                            await Dcontroller.createDoctor(
                                _selectedGender,
                                _nameController.text,
                                _selectedqualification,
                                _selectedexpertise,
                                _selectedexpertiseid,
                                _selectedaffiliation,
                                _expController.text,
                                _onsitefeeController.text,
                                _onlinefeeController.text,
                                selectedCityId,
                                _ageController.text,
                                _dobController.text);
                            //  }
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
                                size: 7.w,
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
