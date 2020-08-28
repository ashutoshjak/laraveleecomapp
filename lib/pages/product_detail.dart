import 'package:ecommerce1/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce1/services/cart_service.dart';


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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);
    if(result > 0){
      _showSnackMessage(Text('Item added to cart successfully!', style: TextStyle(color: Colors.green),));
    } else {
      _showSnackMessage(Text('Failed to add to cart!', style: TextStyle(color: Colors.red),));
    }
  }

  _showSnackMessage(message){
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(this.widget.product.name,),
//        style: TextStyle(fontFamily: "Signatra"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150,
              width: 30,
              child: Stack(
                children: <Widget>[
                  IconButton(
                    iconSize: 30,
                    icon:Icon(Icons.shopping_cart,color: Colors.white,
                    ),
                    onPressed: (){

                    },
                  ),
                  Positioned(
                    child: Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                          size: 25,
                          color: Colors.black,),
                        Positioned(
                          top: 4.0,
                          right: 8.0,
                          child: Center(child: Text('0')),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
//                    leading: Text(this.widget.product.name,style: TextStyle(
//                      color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold
//                    ),),
                  leading: Text('Pieces: ${this.widget.product.quantity}',style: TextStyle(
                      color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold
                  ),),
                    title: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(20.0),),
                         Expanded(
                           child: Text('${this.widget.product.price-this.widget.product.discount}',
                             style: TextStyle(
                              color: Colors.redAccent,fontSize: 20.0,fontWeight: FontWeight.bold
                        ),),
                         ),
                        Expanded(
                          child: Text('${this.widget.product.price}',style: TextStyle(
                              color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough

                          ),
                          ),
                        ),
                      ],
                    ),
//                    subtitle: Row(
//                      children: <Widget>[
//
//                           Text('Pieces: ${this.widget.product.quantity}',style: TextStyle(
//                               color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold
//                           ),),
//

//                      ],
//                    ),
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
                  _addToCart(context,this.widget.product);
                },

                textColor: Colors.redAccent,
                child: Row(
                  children: <Widget>[
                    Text('Add to cart'),
                    IconButton(
                      onPressed: (){
                         _addToCart(context,this.widget.product);
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