// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  UserProduct({
    required this.id,
    required this.title,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListTile(
        minVerticalPadding: 3,
        title: Text(title),
        leading: CircleAvatar(backgroundImage: NetworkImage(imgUrl)),
        trailing: Container(
          width: 98,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: const Icon(Icons.edit),
                color: Colors.blue,
                splashColor: Colors.blueGrey,
                splashRadius: 15,
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).deleteProduct(id);
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
                splashColor: Colors.redAccent,
                splashRadius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
