// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  const CartItemCard(
      {Key? key,
      required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // final prod = Provider.of<CartItem>(context);
    return Dismissible(
      key: ValueKey(productId),
      onDismissed: (direction) {
        cart.removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction)  => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure !!!"),
                  content:
                      Text("Do you want to really remove item from the cart ?"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text("NO"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text("YES"),
                    ),
                  ],
                )),
      background: Container(
        color: Colors.red.shade700,
        child: Icon(
          Icons.delete,
          color: Colors.white70,
        ),
        alignment: Alignment.centerRight,
      ),
      child: Card(
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 18,
                    minRadius: 12,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          price.toString() + " ₹",
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      Text("Total : " + (price * quantity).toString() + " ₹"),
                  trailing: Text("Qty : " + quantity.toString()),
                ),
              ),
              Container(
                width: 50,
                child: Column(children: [
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      cart.increaseQuantity(id);
                    },
                    color: Colors.green,
                    iconSize: 25,
                    splashRadius: 20,
                    splashColor: Colors.lightGreen,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                    ),
                    onPressed: () {
                      cart.decreaseQuantity(id);
                    },
                    color: Colors.red,
                    iconSize: 25,
                    splashRadius: 20,
                    splashColor: Colors.pinkAccent,
                  ),
                ]),
              )
            ]),
          )),
    );
  }
}
