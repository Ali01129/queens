import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/addressPage/addButton.dart';
import 'package:queens/components/backButton.dart';
import 'package:queens/provider/orderProvider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/addressPage/addressTile.dart';
import '../components/cart/bill.dart';
import '../components/cart/cartButton.dart';
import '../components/colors/appColor.dart';
import '../provider/cartProvider.dart';

class Addresspage extends StatefulWidget {
  const Addresspage({super.key});

  @override
  State<Addresspage> createState() => _AddresspageState();
}

class _AddresspageState extends State<Addresspage> {

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  int? selectedIndex=-1;

  List<Map<String, dynamic>> address = [
    {
      'title': 'Home',
      'subtitle': '123 Main Street, City, Country',
    },
    {
      'title': 'Work',
      'subtitle': '456 Office Blvd, City, Country',
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    /// cart provider
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;
    final discount = cartProvider.discount;
    final cartItems = cartProvider.cartItems;

    /// order provider
    final orderProvider = Provider.of<OrderProvider>(context);

    void onTap(){
      if(selectedIndex!=-1) {
        orderProvider.initializeOrder(cartItems: cartItems,discount: discount,total: cart-discount,locationName: address[selectedIndex!]['title'],locationDetails: address[selectedIndex!]['subtitle']);
        Navigator.pushNamed(context, '/paymentPage');
      }
    }

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
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
                    'Deliver to',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: address.isEmpty
                    ? Center(child: Text("No Saved Address"))
                    : ListView.builder(
                  itemCount: address.length + 1,
                  itemBuilder: (context, index) {
                    if (index < address.length) {
                      final item = address[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Addresstile(
                          darkMode: darkMode,
                          icon: 'assets/maps.png',
                          title: item['title'],
                          subtitle: item['subtitle'],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      );
                    } else {
                      return Addbutton(
                        darkMode: darkMode,
                        title: "Add Location +",
                        onTapCallback: () {
                          Navigator.pushNamed(context, '/mapPage');
                        },
                      );
                    }
                  },
                ),
              ),
              Bill(darkMode: darkMode, cartTotal: cart, discount: discount, total: cart-discount),
              SizedBox(height: 2.h),
              Center(
                child: Cartbutton(
                  darkMode: darkMode,
                  title: "NEXT",
                  onTapCallback: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}