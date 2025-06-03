import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queens/components/cart/bill.dart';
import 'package:queens/components/cart/cartButton.dart';
import 'package:queens/components/cart/cartItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/colors/appColor.dart';
import '../provider/cartProvider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = isDarkMode(context);

    void _loadData(){
      Provider.of<CartProvider>(context, listen: false).setCart();
    }

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final cart = cartProvider.cart;
    final discount = cartProvider.discount;

    return Scaffold(
      backgroundColor: darkMode ? AppColors.darkbg : AppColors.lightbg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cart",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(child: Text("Your cart is empty"))
                    : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.5.h),
                      child: Cartitem(image: item['image'], price: item['price'], name: item['name'], darkMode: darkMode, quantity: item['quantity'],onChanged: _loadData,),
                    );
                  },
                ),
              ),
              Bill(darkMode: darkMode,cartTotal: cart,discount: discount,total: cart-discount,),
              SizedBox(height: 2.h,),
              Center(
                child: Cartbutton(darkMode: darkMode, title: "PLACE MY ORDER", onTapCallback: (){
                  if(!cartItems.isEmpty) {
                    Navigator.pushNamed(context, '/addressPage');
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}