import 'package:ecommerce1/models/newproduct.dart';
import 'package:ecommerce1/models/product.dart';
import 'package:ecommerce1/pages/product_detail.dart';
import 'package:flutter/material.dart';

class HomeNewProduct extends StatefulWidget {
//  final String productName;
//  final String productPhoto;
//  final int productPrice;
//  final int productDiscount;
//  final String productDetail;

final Product newproduct;

  HomeNewProduct(this.newproduct);

  @override
  _HomeNewProductState createState() => _HomeNewProductState();
}

class _HomeNewProductState extends State<HomeNewProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(this.widget.newproduct)));
        },
        child: Card(
          child: Column(
            children: <Widget>[
              Text(this.widget.newproduct.name),
              Image.network(widget.newproduct.photo, width: 190.0, height: 160.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Price: ${this.widget.newproduct.price}'),
                  Text('Discount: ${this.widget.newproduct.discount}'),
                ],)

            ],
          ),
        ),
      ),
    );
  }
}
