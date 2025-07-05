import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../database/menu.dart';
import '../backButton.dart';
import '../colors/appColor.dart';
import 'menuItem.dart';
import 'package:queens/components/home/searchBar.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late TextEditingController searchController;
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> filteredItems = [];
  final menu = Menu();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    items = menu.getAllMenu();
    filteredItems = List.from(items);
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) {
        return item['name'].toString().toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButtonWidget(darkMode: darkMode),
                    SizedBox(width: 4.w),
                    Text(
                      "Menu",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Searchbar(
                  controller: searchController,
                  darkMode: darkMode,
                ),
                SizedBox(height: 2.h),

                // Show message if no items are found
                filteredItems.isEmpty
                    ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "No items found",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: darkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ),
                )
                    : GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.75,
                  children: filteredItems.map((item) {
                    return Menuitem(
                      darkMode: darkMode,
                      calories: item['calories'],
                      name: item['name'],
                      price: item['price'],
                      rating: item['rating'],
                      image: item['image'],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}