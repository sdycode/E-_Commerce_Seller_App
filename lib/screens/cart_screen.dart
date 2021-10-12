import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);
  static const String routeName = "/cartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10.0,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Chip(label: Text(cart.totalPrice().toString() + " ₹")),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<Orders>(context, listen: false)
                            .addOrderItem(cart.allItems.values.toList(),
                                cart.totalPrice());

                        cart.clear();
                      });
                      Navigator.of(context).pushNamed(OrderScreen.routeName);
                    },
                    child: const Text(
                      "PLACE ORDER",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cart.allItems.length,
                itemBuilder: (ctx, index) => CartItemCard(
                    id: cart.allItems.values.toList().elementAt(index).id,
                    productId: cart.allItems.keys.toList()[index],
                    title: cart.allItems.values.toList().elementAt(index).title,
                    price: cart.allItems.values.toList().elementAt(index).price,
                    quantity: cart.allItems.values
                        .toList()
                        .elementAt(index)
                        .quantity)),
          )
        ],
      ),
    );
  }
}
