import 'package:ecommerce1/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
//  final String productName;
//  final String productPhoto;
//  final int productPrice;
//  final int productDiscount;
//  final String productDetail;

  final Product product;

  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(this.widget.product.name,style: TextStyle(fontFamily: "Signatra"),),
      ),

      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: GridTile(

              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  child: Image.network(this.widget.product.photo),
                ),
              ),
              footer: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  child: ListTile(
                    leading: Text(this.widget.product.name,style: TextStyle(
                      color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold
                    ),),
                    title: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(20.0),),
                         Expanded(
                           child: Text('${this.widget.product.price-this.widget.product.discount}',style: TextStyle(
                              color: Colors.redAccent,fontSize: 20.0,fontWeight: FontWeight.bold
                        ),),
                         ),
                        Expanded(
                          child: Text('${this.widget.product.price}',style: TextStyle(
                              color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough

                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: (){

                },

                textColor: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Text('Add to cart'),
                    IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.shopping_cart),
                    )
                  ],
                ),
              ),

              IconButton(onPressed: (){

              }, icon: Icon(Icons.favorite_border),
              color: Colors.redAccent,)
            ],),

          Divider(),
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: ListTile(
              title: Text('Product detail',style: TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.w600
              ),),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(this.widget.product.detail),
              ),
            ),
          ),
        ],
      ),
    );
  }
}