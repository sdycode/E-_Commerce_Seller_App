// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/add_product_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/product_screen";

  
  @override
  Widget build(BuildContext context) {
    final pds = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddProductScreen.routeName);
            },
          ),
        ],
      ),
      body: Container(margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(10)),
        height: 500,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: ListView.builder(
                itemBuilder: (_, i) => Column(
                  children: [
                    UserProduct(
                      id: pds.allItems[i].id,
                      title: pds.allItems[i].title,
                      imgUrl: pds.allItems[i].imgUrl,
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: pds.allItems.length,
              ),
            )),
      ),
    );
  }
}


/*
ListView.builder(
            itemBuilder: (_, i) => UserProduct(
                title: products.allItems[i].title,
                imgUrl: products.allItems[i].imgUrl),
            itemCount: products.allItems.length,
          ),


*/