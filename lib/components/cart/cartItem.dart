import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queens/components/colors/appColor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../database/cartData.dart';

class Cartitem extends StatelessWidget {
  final bool darkMode;
  final String name;
  final int price;
  final String image;
  final int quantity;
  final VoidCallback onChanged;
  Cartitem({
    super.key,
    required this.image,
    required this.price,
    required this.name,
    required this.darkMode,
    required this.quantity,
    required this.onChanged
  });

  final cart= CartData();
  void add()async{
    await cart.editCartQuantity(userId: FirebaseAuth.instance.currentUser!.uid,itemName: name,newQuantity: quantity+1 );
    onChanged();
  }
  void substract()async{
    if(quantity==1){
      remove();
    }
    else if(quantity>1){
      await cart.editCartQuantity(userId: FirebaseAuth.instance.currentUser!.uid,itemName: name,newQuantity: quantity-1 );
      onChanged();
    }
  }
  void remove()async{
    await cart.deleteFromCart(userId: FirebaseAuth.instance.currentUser!.uid,itemName: name);
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) => remove(),
            backgroundColor: darkMode?Color(0xFF172437):Color(0xFFd8edf9),
            foregroundColor: AppColors.buttonPrimary,
            icon: Icons.delete_outline,
            borderRadius: BorderRadius.only(topRight: Radius.circular(5.w), bottomRight: Radius.circular(5.w)),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: darkMode ? AppColors.darkcontainer:AppColors.lightcontainer,
          borderRadius: BorderRadius.circular(5.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: Image.asset(
                image,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 4.w),
      
            // Name and Price Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text('£ $price',
                    style: TextStyle(
                      fontSize: 15.sp, color: AppColors.buttonPrimary,fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
      
            // Quantity controls
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed:substract,
                  color: darkMode ? Colors.white : Colors.black,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: add,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}