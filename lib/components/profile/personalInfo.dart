import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../database/userData.dart';
import '../../provider/userProvider.dart';
import '../auth/datePicker.dart';
import '../auth/gender.dart';
import '../backButton.dart';
import '../button.dart';
import '../colors/appColor.dart';
import '../textField.dart';

class Personalinfo extends StatefulWidget {
  const Personalinfo({super.key});

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();

  String selectedGender='Male';

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserProvider>(context, listen: false).user;

      print("Fetched gender from userProvider: ${user!.gender}"); // <-- debug
      print("Gender matches 'Female'? ${user.gender == "Female"}"); // <-- debug

      setState(() {
        nameController.text = user.name;
        phoneController.text = user.phone;
        dateController.text = user.date;

        final genders = ['Male', 'Female', 'Other'];
        selectedGender = genders.contains(user.gender)
            ? user.gender
            : 'Male';

        print("Setting selectedGender: $selectedGender"); // <-- debug
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BackButtonWidget(darkMode: darkMode),
                          SizedBox(width: 4.w),
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      buildLabel("Full Name", darkMode),
                      CustomTextfield(
                        controller: nameController,
                        focusNode: nameFocusNode,
                        hintText: "Enter your full name",
                        isPassword: false,
                      ),
                      SizedBox(height: 3.h),
                      GenderDropdown(
                        initialVal: selectedGender,
                        onGenderChanged: (gender) {
                          setState(() {
                            selectedGender = gender;
                          });
                        },
                      ),
                      SizedBox(height: 3.h),
                      buildLabel("Phone Number", darkMode),
                      CustomTextfield(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        hintText: "Enter your phone number",
                        isPassword: false,
                      ),
                      SizedBox(height: 3.h),
                      buildLabel("Birth Date", darkMode),
                      BirthDatePicker(
                        controller: dateController,
                        focusNode: dateFocusNode,
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
              Button(
                title: "Save Changes",
                textColor: Colors.white,
                bg: AppColors.buttonPrimary,
                onTapCallback: () async {
                  try {
                    await UserData().updateUserData(
                      name: nameController.text.trim(),
                      gender: selectedGender,
                      phoneNumber: phoneController.text.trim(),
                      dateOfBirth: dateController.text.trim(),
                    );
                    final userValue = Provider.of<UserProvider>(context, listen: false);
                    final data = await UserData().getUserData();
                    UserModel _user=UserModel(date: data?['dateOfBirth'],name: data?['name'], image: data?['imageUrl'], gender: data?['gender'], phone: data?['phoneNumber'], email:data?['email']);
                    userValue.setUser(_user);
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update profile")),
                    );
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label, bool darkMode) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: darkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}