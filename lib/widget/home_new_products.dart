import 'package:ecommerce1/models/newproduct.dart';
import 'package:ecommerce1/models/product.dart';
import 'package:flutter/material.dart';

import 'home_new_product.dart';



class HomeNewProducts extends StatefulWidget {

  final List<NewProduct> newproductList;

  HomeNewProducts({this.newproductList});

  @override
  _HomeNewProductsState createState() => _HomeNewProductsState();
}

class _HomeNewProductsState extends State<HomeNewProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.newproductList.length,
        itemBuilder: (context, index){
          return HomeNewProduct(
            this.widget.newproductList[index].name,
            this.widget.newproductList[index].photo,
            this.widget.newproductList[index].price,
            this.widget.newproductList[index].discount,
          );
        },
      ),
    );
  }
}
