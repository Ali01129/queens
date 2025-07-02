import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../provider/addressProvider.dart';
import '../bottomSheet.dart';
import '../../database/address.dart';

class Locationtile extends StatelessWidget {
  final bool darkMode;
  final String title;
  final String subtitle;

  Locationtile({
    super.key,
    required this.darkMode,
    required this.subtitle,
    required this.title,
  });

  final locationData = AddressData();
  void remove(BuildContext context) async {
    await locationData.deleteLocation(locationName: title);
    Provider.of<AddressProvider>(context, listen: false).setAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.w),
        child: Slidable(
          key: ValueKey(title),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) => showDeleteBottomSheet(
                  context,
                  darkMode: darkMode,
                  text: "Are you sure you want to Delete this?",
                  icon: Icons.delete,
                  buttonText: "Yes, Delete",
                  onDelete: () {
                    remove(context);
                  },
                ),
                backgroundColor: darkMode
                    ? const Color(0xFF172437)
                    : const Color(0xFFd8edf9),
                foregroundColor: AppColors.buttonPrimary,
                icon: Icons.delete_outline,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.w),
                  bottomRight: Radius.circular(4.w),
                ),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(2.h),
            color: darkMode
                ? AppColors.darkcontainer
                : AppColors.lightcontainer,
            child: Row(
              children: [
                Image.asset(
                  'assets/maps.png',
                  height: 6.h,
                  width: 6.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: darkMode
                              ? Colors.grey[300]
                              : Colors.grey[700],
                        ),
                      ),
                    ],
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