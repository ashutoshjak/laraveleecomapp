import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeHotProduct extends StatefulWidget {
  final String productName;
  final String productPhoto;
  final int productPrice;
  final int productDiscount;
  HomeHotProduct(this.productName, this.productPhoto, this.productPrice, this.productDiscount );
  @override
  _HomeHotProductState createState() => _HomeHotProductState();
}

class _HomeHotProductState extends State<HomeHotProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(this.widget.productName),
            Image.network(widget.productPhoto, width: 190.0, height: 160.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Text('Price: ${this.widget.productPrice}'),
              Text('Discount: ${this.widget.productDiscount}'),
            ],)

          ],
        ),
      ),
    );
  }
}