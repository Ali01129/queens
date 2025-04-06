import 'package:flutter/material.dart';
import 'package:queens/components/button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/backButton.dart';

class Uploadphoto extends StatefulWidget {
  const Uploadphoto({super.key});

  @override
  State<Uploadphoto> createState() => _UploadphotoState();
}

class _UploadphotoState extends State<Uploadphoto> {
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  // pick image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? Color(0xFF181e22) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BackButtonWidget(darkMode: darkMode),
                        SizedBox(width: 4.w),
                        Text(
                          "Upload Your Photo",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "Upload a photo to save data involves transferring an image file to storage location",
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(
                      child: _image == null
                          ? GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: darkMode ? Color(0xFF24292d) : Colors.white,
                            boxShadow: darkMode
                                ? []
                                : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.file_upload_rounded),
                              SizedBox(height: 2.w),
                              Text(
                                "Upload Your File",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: darkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: darkMode ? Colors.white70 : Colors.black87,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(2.w),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                onTapCallback: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
