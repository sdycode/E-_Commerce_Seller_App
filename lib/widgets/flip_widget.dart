import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipImage extends StatefulWidget {
  
   


  FlipImage(String imgUrl);

  @override
  State<FlipImage> createState() => _FlipImageState();
}

class _FlipImageState extends State<FlipImage> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: FlipCard(
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
           " widget.im"
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
              "https://thumbs.dreamstime.com/b/playing-cards-4765919.jpg",
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
