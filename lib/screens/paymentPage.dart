import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/addressPage/addButton.dart';
import 'package:queens/components/backButton.dart';
import 'package:queens/database/order.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/addressPage/addressTile.dart';
import '../components/cart/bill.dart';
import '../components/cart/cartButton.dart';
import '../components/colors/appColor.dart';
import '../components/order/showOrderPlacedBottomSheet.dart';
import '../provider/cartProvider.dart';
import '../provider/myOrdresProvider.dart';
import '../provider/orderProvider.dart';

class Paymentpage extends StatefulWidget {
  const Paymentpage({super.key});

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  int? selectedIndex=-1;

  List<Map<String, dynamic>> address = [
    {
      'title': 'Cash Payment',
      'subtitle': 'Cash on Delivery',
      'icon':'assets/cash.png'
    },
    {
      'title': 'Card Payment',
      'subtitle': 'Card',
      'icon':'assets/card.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;
    final discount = cartProvider.discount;

    /// order provider
    final orderProvider = Provider.of<OrderProvider>(context);

    void onTap()async{
      if(selectedIndex!=-1){
        orderProvider.setPayment(address[selectedIndex!]['title'], 'Pending');
        String orderId = await orderProvider.add_to_Database();
        orderProvider.clearOrder();
        cartProvider.clearCart();
        Provider.of<Myordresprovider>(context,listen:false).setMyOrders();
        ///show bottom sheet
        showOrderPlacedBottomSheet(
          context,
          darkMode: darkMode,
          orderId: orderId,
          onHomePressed: () {
            Navigator.pushReplacementNamed(context, '/bottom');
          },
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
              Row(
                children: [
                  BackButtonWidget(darkMode: darkMode),
                  SizedBox(width: 4.w),
                  Text(
                    'Payment method',
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
                    ? Center(child: Text("No Saved Payment Options"))
                    : ListView.builder(
                  itemCount: address.length + 1,
                  itemBuilder: (context, index) {
                    if (index < address.length) {
                      final item = address[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Addresstile(
                          darkMode: darkMode,
                          icon: item['icon'],
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
                        title: "Add Card +",
                        onTapCallback: () {},
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