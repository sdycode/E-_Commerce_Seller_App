import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shop_app/providers/order.dart';

class OrderItemSample extends StatefulWidget {
  final OrderItem orderItem;
  OrderItemSample({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  State<OrderItemSample> createState() => _OrderItemSampleState();
}

class _OrderItemSampleState extends State<OrderItemSample> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Column(children: [
        ListTile(
          title: Text(widget.orderItem.amount.toString()),
          subtitle: Text(
            DateFormat('dd-MM-yyyy : hh:mm a')
                .format(widget.orderItem.dateTime),
          ),
          trailing: IconButton(
              icon: _expanded
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              }),
        ),
        if (_expanded)
          Container(
            height: min(widget.orderItem.products.length * 20.0 + 100, 80),
            child: ListView(
              children: widget.orderItem.products
                  .map(
                    (prod) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(prod.title),
                          Text(
                            (prod.quantity * prod.price).toString(),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ]),
    );
  }
}
