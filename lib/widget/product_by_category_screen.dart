import 'dart:convert';

import 'package:ecommerce1/models/product.dart';
import 'package:ecommerce1/widget/product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProductsByCategoryScreen extends StatefulWidget {

  final String categoryName;
  final int categoryId;

  ProductsByCategoryScreen({this.categoryName, this.categoryId});

  @override
  _ProductsByCategoryScreenState createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  String categoryId;


  getProductsByCategoryId(String categoryId) async{
    var products = await http.get("http://192.168.100.7/ecommerce/public/api/get-products-by-category/${this.widget.categoryId}");
    var _list = json.decode(products.body);
    print(_list);
    print(_list);
    _list['data'].forEach((data){
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.detail = data['detail'];

      setState(() {
        _productListByCategory.add(model);
      });

    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getProductsByCategoryId(categoryId);
  }


  List<Product> _productListByCategory = List<Product>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(this.widget.categoryName,style: TextStyle(fontFamily: "Signatra"),),
        centerTitle: true,
      ),
      body:  Container(
        child:  GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            itemCount: _productListByCategory.length,
            itemBuilder: (context,index){
              return ProductByCategory(this._productListByCategory[index]);
            }
        ),
      ),
    );
  }
}
