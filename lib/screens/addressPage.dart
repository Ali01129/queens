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
import '../provider/addressProvider.dart';

class Addresspage extends StatefulWidget {
  const Addresspage({super.key});

  @override
  State<Addresspage> createState() => _AddresspageState();
}

class _AddresspageState extends State<Addresspage> {
  int? selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  void fetchAddresses() async {
    await Provider.of<AddressProvider>(context, listen: false).setAddresses();
  }

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    /// Providers
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final addressList = addressProvider.addresses;

    final cart = cartProvider.cart;
    final discount = cartProvider.discount;
    final cartItems = cartProvider.cartItems;

    void onTap() {
      if (selectedIndex != -1 && selectedIndex! < addressList.length) {
        final selected = addressList[selectedIndex!];
        orderProvider.initializeOrder(
          cartItems: cartItems,
          discount: discount,
          total: cart - discount,
          locationName: selected['name'],
          locationDetails:
          "Lat: ${selected['latitude']}, Long: ${selected['longitude']}",
        );
        Navigator.pushNamed(context, '/paymentPage');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an address')),
        );
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
              // Header
              Row(
                children: [
                  BackButtonWidget(darkMode: darkMode),
                  SizedBox(width: 4.w),
                  Text(
                    'Deliver to',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Address List
              Expanded(
                child: addressList.isEmpty
                    ? Center(
                  child: Text(
                    "No Saved Address",
                    style: TextStyle(
                      color: darkMode ? Colors.white70 : Colors.black54,
                      fontSize: 16.sp,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: addressList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < addressList.length) {
                      final item = addressList[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Addresstile(
                          darkMode: darkMode,
                          icon: 'assets/maps.png',
                          title: item['name'],
                          subtitle:
                          "Lat: ${item['latitude']}, Long: ${item['longitude']}",
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

              // Billing Info
              Bill(
                darkMode: darkMode,
                cartTotal: cart,
                discount: discount,
                total: cart - discount,
              ),
              SizedBox(height: 2.h),

              // Next Button
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