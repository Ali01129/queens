import 'package:flutter/material.dart';
import 'package:queens/database/order.dart';

class Myordresprovider extends ChangeNotifier{
  List<Map<String, dynamic>> orders=[];

  void setMyOrders()async{
    final orderService = Order();
    orders = await orderService.getAllOrders();
    notifyListeners();
  }
  void clearMyOrder(){
    orders=[];
    notifyListeners();
  }
}