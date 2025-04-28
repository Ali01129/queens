import "package:flutter/material.dart";
import "package:queens/components/auth/datePicker.dart";
import "package:queens/components/auth/gender.dart";
import "package:queens/components/backButton.dart";
import "package:queens/components/button.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "../components/alert_dialog.dart";
import "../components/textField.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> saveBasicUserInfo({
    required String name,
    required String gender,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'uid': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    FocusNode dateFocusNode = FocusNode();
    FocusNode nameFocusNode = FocusNode();
    FocusNode phoneFocusNode = FocusNode();

    String selectedGender = "Male";

    void sendData()async{
      if (nameController.text.isEmpty ||selectedGender == null ||phoneController.text.isEmpty ||dateController.text.isEmpty) {
        showCustomAlertDialog(
          context,
          'Error',
          'Fill all the details first.',
        );
      }
      else{
        showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
        await saveBasicUserInfo(
          name: nameController.text,
          gender: selectedGender,
          phoneNumber: phoneController.text,
          dateOfBirth: dateController.text,
        );
        Navigator.pushNamed(context, '/uploadPhoto');
      }
    }

    return Scaffold(
      backgroundColor: darkMode ? Color(0xFF181e22) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BackButtonWidget(darkMode: darkMode),
                        SizedBox(width: 4.w),
                        Text(
                          "Fill in all fields",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Fill all fields for security",
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Full Name",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? Colors.white : Colors.black),
                    ),
                    SizedBox(height: 1.h),
                    CustomTextfield(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      validator: (String name) {
                        return name.trim().length >= 3;
                      },
                      hintText: "Enter your full name",
                      isPassword: false,
                    ),
                    SizedBox(height: 3.h),
                    GenderDropdown(
                      onGenderChanged: (gender) {
                        setState(() {
                          selectedGender = gender;
                        });
                      },
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? Colors.white : Colors.black),
                    ),
                    SizedBox(height: 1.h),
                    CustomTextfield(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      validator: (String name) {
                        final RegExp ukPhoneRegex =
                        RegExp(r'^(?:\+44|0)7\d{9}$');
                        return ukPhoneRegex.hasMatch(name.trim());
                      },
                      hintText: "Enter your phone number",
                      isPassword: false,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Birth Date",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: darkMode ? Colors.white : Colors.black),
                    ),
                    SizedBox(height: 1.h),
                    BirthDatePicker(
                      controller: dateController,
                      focusNode: dateFocusNode,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Button(
                title: "NEXT",
                textColor: Colors.white,
                bg: Color(0xFF0d5ef9),
                onTapCallback: sendData
              ),
            ),
          ],
        ),
      ),
    );
  }
}