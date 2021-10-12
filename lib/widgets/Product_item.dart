// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatefulWidget {
  // final String id;
  // final String title;
  // final String imgUrl;

  // ignore: use_key_in_widget_constructors
  // const ProductItem(
  //   this.id,
  //   this.title,
  //   this.imgUrl,
  // );
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final singleProduct = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    singleProduct.changeCartStatus();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: singleProduct.id);
          },
          child: Image.network(
            singleProduct.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            singleProduct.title,
          ),
          leading: Consumer<Product>(
            child: Text("Never changes"),
            builder: (ctx, singleProduct, child) => IconButton(
              icon: Icon(
                singleProduct.isFaviourate
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: singleProduct.isFaviourate == true
                  ? Colors.red
                  : Colors.white,
              onPressed: () {
                singleProduct.changeFavouriteStatus();
              },
            ),
          ),
          backgroundColor: Colors.black45,
          trailing: IconButton(
            icon: Consumer<Product>(
              builder: (ctx, singleProduct, child) => Icon(
                Icons.shopping_bag,
                color: singleProduct.isAddedInCart ? Colors.white : Colors.red,
              ),
            ),
            onPressed: () {
              singleProduct.changeCartStatus();
              print(singleProduct.title +
                  " is in Cart :" +
                  singleProduct.isAddedInCart.toString());

              if (singleProduct.isAddedInCart == false) {
                print("Item added : " + singleProduct.title);
                cart.addItem(
                  singleProduct.id,
                  singleProduct.price,
                  singleProduct.title,
                );
              } else {
                dynamic newKey = "";
                cart.allItems.forEach((key, value) {
                  if (value.id == singleProduct.id) {
                    cart.removeItem(key);
                    print("Item removed is -> " +
                        value.title +
                        " key is : " +
                        key.toString());
                  }
                });
              }

              // ignore: deprecated_member_use
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: singleProduct.isAddedInCart == false
                    ? const Text("Item added to cart !!!")
                    : const Text("Item removed from cart !!!"),
                duration: const Duration(milliseconds: 1000),
                action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(singleProduct.id);
                    }),
              ));
            },
          ),
        ),
      ),
    );
  }

  void showToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.0);
  }
}
