import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/products.dart';

import '../providers/product.dart';
import 'Product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFvs;
  const ProductGrid( {
    Key? key,
     required this.showFvs,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productList = showFvs ? productsData.favouriteItems : productsData.allItems;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: productList[i],
        // create: (c) => productList[i],
        child: ProductItem(
            // productList[i].id, productList[i].title, productList[i].imgUrl
            ),
      ),
      itemCount: productList.length,
    );
  }
}
