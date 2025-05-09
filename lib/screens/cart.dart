import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/cart/bill.dart';
import 'package:queens/components/cart/cartButton.dart';
import 'package:queens/components/cart/cartItem.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../components/colors/appColor.dart';
import '../database/cartData.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cartData = CartData();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  double cart=0.0;
  double discount=0.0;
  void _loadData() async {
    final items = await cartData.getCartItems(userId: uid);
    setState(() {
      cartItems = items;
    });
    cart=0.0;
    for (int i = 0; i < cartItems.length; i++) {
      cart += cartItems[i]['price'] * cartItems[i]['quantity'];
    }
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
                  Navigator.pushNamed(context, '/addressPage');
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}