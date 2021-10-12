import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
   OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/order_screen";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
       drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItemSample(
          orderItem: orderData.allOrderedItems[i],
        ),
        itemCount: orderData.allOrderedItems.length,
      ),
    );
  }
}
