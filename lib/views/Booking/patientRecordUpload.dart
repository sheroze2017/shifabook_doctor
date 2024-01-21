import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Controller/booking/patientRecordAdd.dart';

class PatientRemark extends StatefulWidget {
  final int patientId;
  final int bookingId;
  PatientRemark({required this.patientId, required this.bookingId});

  @override
  State<PatientRemark> createState() => _PatientRemarkState();
}

class _PatientRemarkState extends State<PatientRemark> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _remarksController = TextEditingController();
  ImageController controller = Get.put(ImageController());
  // Add logic to handle attachments here
  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Remark',
          style: TextStyle(color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    controller: _remarksController,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter remarks';
                      }
                      return null;
                    },
                    // Allows for multiple lines of text
                    decoration: const InputDecoration(
                      labelText: 'Remarks',
                      hintText: 'Enter remarks here',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black), // Change the color here
                      ),
                    )),
                const SizedBox(height: 16.0),
                Obx(() {
                  final selectedImage = controller.selectedImage.value;
                  if (selectedImage != null) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {
                                controller.selectedImage.value = null;
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.grey,
                              )),
                        ),
                        Image.file(
                          selectedImage,
                          width: 20.h,
                          height: 20.h,
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('No image selected'));
                  }
                }),
                Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    width: 40.w,
                    height: 5.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.pickImage(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.indigo[900],
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: Obx(
                        () {
                          if (controller.loader.value) {
                            return SpinKitWave(
                              color: Colors.white,
                              size: 6.w,
                            );
                          } else {
                            return Text(
                              "Attach File",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    width: 40.w,
                    height: 5.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        // // _getFromCamera() async {
                        // XFile? pickedFile = await ImagePicker()
                        //     .pickImage(source: ImageSource.camera);
                        // if (pickedFile != null) {
                        //   print(pickedFile.readAsString());
                        //   File imageFile = File(pickedFile.path);
                        //   print(imageFile.toString());
                        // }
                        // //  }

                        if (_formKey.currentState!.validate()) {
                          print('donee');
                          if (controller.imagelink != '') {
                            await controller.addRemark(
                                _remarksController.text.toString(),
                                widget.patientId,
                                widget.bookingId);
                          } else {
                            Get.snackbar(
                                'Error', 'Add Image to update Remarks');
                          }
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
                      child: Obx(
                        () {
                          if (controller.loader2.value) {
                            return SpinKitWave(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              size: 6.w,
                            );
                          } else {
                            return Text(
                              "Save Record",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
