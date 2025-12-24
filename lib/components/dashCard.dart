import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/helper/delets.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/favoraitesProducts.dart';
import 'package:delivery_app/model/productsmodel.dart';
import 'package:delivery_app/screens/DetailProductScreen.dart';
import 'package:delivery_app/service/getFavoraites.dart';

class Dashcard extends StatefulWidget {
  final String productName;
  final String storeName;
  final int productId;
  final int storeId;
  final String description;
  final int quantity;
  final String price;
  final String? image;
  final String access_token;
  final String favoraiteId;
  Color heartColor;

  Dashcard({
    required this.productName,
    required this.storeName,
    required this.productId,
    required this.storeId,
    required this.description,
    required this.quantity,
    required this.price,
    this.image,
    required this.access_token,
    required this.heartColor,
    required this.favoraiteId,
  });

  @override
  State<Dashcard> createState() => _DashcardState(
    productName: productName,
    storeName: storeName,
    price: price,
    productId: productId,
    storeId: storeId,
    quantity: quantity,
    description: description,
    access_token: access_token,
    heartColor: heartColor,
    favoraiteId: favoraiteId,
  );
}

class _DashcardState extends State<Dashcard> {
  final String productName;
  final String storeName;
  final int productId;
  final int storeId;
  final String description;
  final int quantity;
  final String price;
  final String? image;
  final String access_token;
  Color heartColor;
  final String favoraiteId;

  _DashcardState({
    required this.productName,
    required this.storeName,
    required this.productId,
    required this.storeId,
    required this.description,
    required this.quantity,
    required this.price,
    this.image,
    required this.access_token,
    required this.heartColor,
    required this.favoraiteId,
  });

  @override
  final Color favoriteColor = red; // اللون عند التفعيل
  final Color defaultColor = grey.withOpacity(0.40); // اللون الافتراضي
  // اللون الحالي
  @override
  Widget build(BuildContext context) {
    ProductsModel products = ProductsModel(
      productName: productName,
      storeName: storeName,
      productId: productId,
      storeId: storeId,
      description: description,
      quantity: quantity,
      price: price,
      heartColor: heartColor,
      favoraiteId: favoraiteId,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        //====================================================================
        //===================== full container ======================
        //====================================================================
        child: Container(
          decoration: BoxDecoration(
            color: grey.withOpacity(0.20),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 240,
          width: 175,
          child: Stack(
            children: [
              //====================================================================
              //===================== Products image container ======================
              //====================================================================
              Container(
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 180,
                height: 160,
              ),
              //====================================================================
              //===================== Products name container ======================
              //====================================================================
              Container(
                alignment: Alignment(-1, 0.68),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    productName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),

              //====================================================================
              //===================== store name container ======================
              //====================================================================
              Container(
                alignment: Alignment(-1, 0.85),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Text(
                    storeName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              //====================================================================
              //===================== price container ======================
              //====================================================================
              Container(
                alignment: Alignment(-0.8, -0.88),
                child: Container(
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 75,
                  height: 35,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$price',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Icon(Icons.attach_money, color: yellow, size: 20),
                    ],
                  ),
                ),
              ),

              //====================================================================
              //===================== rating container ======================
              //====================================================================
              Container(
                alignment: Alignment(-0.8, 0.33),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: yellow.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 75,
                  height: 35,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4.5',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      VerticalDivider(color: Colors.white, width: 5),
                      Icon(Icons.star, color: yellow, size: 20),
                    ],
                  ),
                ),
              ),
              //====================================================================
              //===================== love container ======================
              //====================================================================
              Container(
                alignment: Alignment(0.8, -0.9),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: products.heartColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onTap: () async {
                    print('QQQQQQQ5555555');
                    print(products.productId);
                    print(products.storeId);
                    if (heartColor == grey) {
                      http.Response response = await posts(
                        url:
                            'http://10.0.2.2:8000/api/v1/user/favorites/add-product',
                        body: {
                          'product_id': products.productId.toString(),
                          'store_id': products.storeId.toString(),
                        },
                        token: access_token,
                      );
                      print(jsonDecode(response.body));
                      if (response.statusCode == 201) {
                        setState(() {
                          heartColor = red;
                        });
                      }
                    } else if (heartColor == red) {
                      print("QQQQQQ $favoraiteId");

                      http.Response response = await delets(
                        url: 'http://10.0.2.2:8000/api/v1/user/favorites',
                        body: {"favorite_id": favoraiteId},
                        token: access_token,
                      );

                      Map<String, dynamic> data = jsonDecode(response.body);
                      print(data);
                      if (response.statusCode == 200) {
                        setState(() {
                          heartColor = grey;
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          print('QQQQQQQ555555');
          print(productId);
          print(productName);
          print(storeId);
          print(storeName);
          print(price);
          print(description);
          print(quantity);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProductScreen(
                product: products,
                token: access_token,
                storeId: storeId,
              ),
            ),
          );
        },
      ),
    );
  }
}

List<ProductsModel> publicListProductsFavorite = [];
