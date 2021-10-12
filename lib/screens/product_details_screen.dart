import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/custom_flip.dart';
import 'package:shop_app/widgets/flip_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/product_detail';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
   late Animation<double> text_animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    controller.forward();
    text_animation= Tween<double>(begin: 1, end: 1.2).animate(controller);
    animation = Tween<double>(begin: 3, end: 5).animate(controller);
  
    
    
    animation.addListener(() {
      if (animation.isCompleted) {
        controller.reverse();
      } else if (animation.isDismissed) {
        controller.forward();
      }
    });

      text_animation.addListener(() {
      if (text_animation.isCompleted) {
        controller.reverse();
      } else if (text_animation.isDismissed) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context, listen: false)
        .findProductById(productId);
    return Scaffold(
      
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                  child: CustomFlipCard(
                front: Image.network(
                  loadedProduct.imgUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
                back: Image.network(
                  loadedProduct.backImgUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
              )),
            ),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                ScaleTransition(
                    scale: animation,
                    child: const Icon(Icons.arrow_left_rounded)),
                ScaleTransition(
                  scale: text_animation,
                  child: const  Text(
                    "Swipe",
                    style: TextStyle(
                      color: Colors.brown,
                    decorationColor: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                ScaleTransition(
                    scale: animation,
                    child: const Icon(Icons.arrow_right_rounded)),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(loadedProduct.price.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text(loadedProduct.title, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(20),
              child:
                  Text(loadedProduct.description, textAlign: TextAlign.center),
            ),
            ElevatedButton(
              child: const Icon(Icons.present_to_all),
              onPressed: () {
                controller.forward();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*

FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xFF006666),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Image.network(
          loadedProduct.imgUrl
           ,
            fit: BoxFit.cover,
          ),
        ),
        back: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFF006666),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Image.network(
              loadedProduct.backImgUrl,
              fit: BoxFit.cover,
            )),
      ),
      */