import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderItems = [];
  List<OrderItem> get allOrderedItems {
    return [..._orderItems];
  }

  int ordersCount() {
    return _orderItems.length;
  }

  void addOrderItem(List<CartItem> productsList, double totalAmt) {
    if (totalAmt > 0) {
      _orderItems.insert(
          0,
          OrderItem(DateTime.now().toString(), totalAmt, productsList,
              DateTime.now()));
    }

    notifyListeners();
  }
}
