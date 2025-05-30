import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/home/searchBar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../database/menu.dart';
import '../../provider/categorieProvider.dart';
import '../backButton.dart';
import '../colors/appColor.dart';
import 'menuItem.dart';

class Categoriepage extends StatefulWidget {
  const Categoriepage({super.key});

  @override
  State<Categoriepage> createState() => _CategoriepageState();
}

class _CategoriepageState extends State<Categoriepage> {
  late TextEditingController searchController;
  late List<Map<String, dynamic>> items;
  late List<Map<String, dynamic>> filteredItems;
  final menu = Menu();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentCategory = Provider.of<CategoryProvider>(context).currentCategory;
    items = menu.getMenuByCategory(currentCategory);
    filteredItems = List.from(items);
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
    final currentCategory = Provider.of<CategoryProvider>(context).currentCategory;
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
                      currentCategory,
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
                GridView.count(
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