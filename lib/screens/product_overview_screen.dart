// ignore_for_file: avoid_print, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/product_grid.dart';
import 'package:provider/provider.dart';

enum menuOptions {
  All,
  Favourites,
}

class ProductOverview extends StatefulWidget {
  ProductOverview({Key? key}) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  List<Product> loadedProducts = [];
  var showFavourites = false;
  @override
  void initState() {
    Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsList = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Grocery Shop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (menuOptions selectedValue) {
              setState(() {
                if (selectedValue == menuOptions.Favourites) {
                  showFavourites = true;
                } else {
                  showFavourites = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Favourites"),
                value: menuOptions.Favourites,
              ),
              const PopupMenuItem(
                child: Text("All"),
                value: menuOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: const Icon(Icons.shopping_cart_sharp)),
              color: Colors.red,
              value: cart.itemsCount().toString(),
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showFvs: showFavourites,
      ),
    );
  }
}
