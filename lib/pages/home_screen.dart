import 'package:ecommerce1/models/category.dart';
import 'package:ecommerce1/models/newproduct.dart';
import 'package:ecommerce1/models/product.dart';
import 'package:ecommerce1/pages/cart_screen.dart';
import 'package:ecommerce1/services/cart_service.dart';
import 'package:ecommerce1/widget/carousel_slider.dart';
import 'package:ecommerce1/widget/home_hot_products.dart';
import 'package:ecommerce1/widget/home_new_products.dart';
import 'package:ecommerce1/widget/home_product_categories.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  String urlslider = "http://192.168.100.7/ecommerce/public/api/sliders";

  String urlcategory = "http://192.168.100.7/ecommerce/public/api/categories";

  String urlgethotproduct = "http://192.168.100.7/ecommerce/public/api/get-all-hot-products";

  String urlgetnewproduct = "http://192.168.100.7/ecommerce/public/api/get-all-new-products";

  //String urlgetproductbycategoryid = "" + "/" + categoryId.toString();
//  192.168.100.7

//  10.0.2.2
  var items= [];
  List<Category> _categoryList = List<Category>();
  List<Product> _productList = List<Product>();
  List<Product> _newproductList = List<Product>();
  CartService _cartService = CartService();

  List<Product> _cartItems;



  static var categoryId;



  getSlider() async{
    var sliders = await http.get(urlslider);
    var result = json.decode(sliders.body);
    print("Get Slider");
    print(result);
    result['data'].forEach((data){
     setState(() {
       items.add(NetworkImage(data['image_url']));
     });
    });
}

  getCategory() async{
    var categories = await http.get(urlcategory);
    var result = json.decode(categories.body);
    print("Get Category");
    print(result);
    result['data'].forEach((data){
      var model = Category();
      model.id = data['id'];
      model.name = data['categoryName'];
      model.icon = data['categoryIcon'];
      setState(() {
        _categoryList.add(model);
      });
    });
  }

  getAllHotProduct() async{
    var hotProducts = await http.get(urlgethotproduct);
    var result = json.decode(hotProducts.body);
    print("Get Hot Product");
    print(result);
    result['data'].forEach((data){
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.detail = data['detail'];
      model.quantity = data['quantity'];

      setState(() {
        _productList.add(model);
      });
    });
  }

  getAllNewProduct() async{
    var newProducts = await http.get(urlgetnewproduct);
    var result = json.decode(newProducts.body);
    print("Get New Product");
    print(result);
    result['data'].forEach((data){
      var model = Product();
      model.id = data['id'];
      model.name = data['name'];
      model.photo = data['photo'];
      model.price = data['price'];
      model.discount = data['discount'];
      model.detail = data['detail'];
      model.quantity = data['quantity'];

      setState(() {
        _newproductList.add(model);
      });
    });
  }

  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data){
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto'];
      product.price = data['productPrice'];
      product.discount = data['productDiscount'];
      product.detail = data['productDetail'] ?? 'No detail';
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }





//  getProductsByCategoryId(String categoryId) async{
//      await http.get("http://192.168.100.7/ecommerce/public/api/get-products-by-category"+ "/" + categoryId.toString());
//
//  }


//  getProductsByCategoryId(String categoryId) async{
//    var products = await http.get("http://192.168.100.7/ecommerce/public/api/get-products-by-category/8");
//    var _list = json.decode(products.body);
//    print("Product by id");
//    print(_list);
//    _list['data'].forEach((data){
//      var model = Product();
//      model.id = data['id'];
//      model.name = data['name'];
//      model.photo = data['photo'];
//      model.price = data['price'];
//      model.discount = data['discount'];
//
//      setState(() {
//        _productListByCategory.add(model);
//      });
//
//    });
//  }



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getSlider();
    getCategory();
    getAllHotProduct();
    getAllNewProduct();
    _getCartItems();
//    getProductsByCategoryId(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("eComm App",),
//        style: TextStyle(fontFamily: "Signatra"),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>CartScreen(_cartItems)
              ));
            },
            child: Padding(
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
                            child: Center(child: Text(_cartItems.length.toString())),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            carouselSlider(items),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Product Categories'),
            ),
            HomeProductCategories(categoryList: _categoryList,),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Hot Products'),
            ),
            HomeHotProducts(productList: _productList,),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('New Products'),
            ),
            HomeNewProducts(productList: _newproductList,)

          ],
        ),
      ),
    );
  }
}
