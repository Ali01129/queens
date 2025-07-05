import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/addressPage/locationTile.dart';
import "package:responsive_sizer/responsive_sizer.dart";
import '../components/backButton.dart';
import '../components/colors/appColor.dart';
import '../provider/addressProvider.dart';

class Locationpage extends StatelessWidget {
  const Locationpage({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {

    bool darkMode = isDarkMode(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final addressList = addressProvider.addresses;

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  BackButtonWidget(darkMode: darkMode),
                  SizedBox(width: 4.w),
                  Text(
                    'My Locations',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Swipe left to delete saved Location",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.containerText,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Expanded(  // This makes the listview take remaining space
              child: addressList.isEmpty
                  ? Center(
                child: Text(
                  "No Saved Address",
                  style: TextStyle(
                    color: darkMode ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  final address = addressList[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Locationtile(
                        darkMode: darkMode,
                        title: address['name'],
                        subtitle: "Lat: ${address['latitude']}, Long: ${address['longitude']}",
                      onDelete: (){
                        Provider.of<AddressProvider>(context, listen: false).deleteAddresses(address['name']);
                      },

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
