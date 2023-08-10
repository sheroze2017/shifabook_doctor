import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final String? labeltext;
  const CustomTextFormField({
    Key? key,
    required this.focusNode,
    this.labeltext,
    required this.controller,
    required this.hintText,
    required this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      child: TextFormField(
        focusNode: focusNode,
        style: GoogleFonts.lato(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(90.0),
              ),
              borderSide: BorderSide(color: Colors.indigo, width: 2)),
          filled: true,
          fillColor: Colors.grey[350],
          labelText: labeltext,
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            color: Colors.black26,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}
