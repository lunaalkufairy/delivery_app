import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:delivery_app/components/SideBarBotton.dart';
import 'package:delivery_app/components/dashCard.dart';
import 'package:delivery_app/components/storeContainer.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/productsmodel.dart';
import 'package:delivery_app/model/profile.dart';
import 'package:delivery_app/model/stores.dart';
import 'package:delivery_app/screens/storeProductScreen.dart';
import 'package:delivery_app/service/getAllStores.dart';
import 'package:delivery_app/service/getFavoraites.dart';
import 'package:delivery_app/service/getProducts.dart';

class DashbordScreen extends StatefulWidget {
  final Profile profile;
  final String access_token;

  DashbordScreen({
    super.key,
    required this.profile,
    required this.access_token,
  });

  @override
  State<DashbordScreen> createState() =>
      _DashbordScreenState(access_token: access_token, profile: profile);
}

class _DashbordScreenState extends State<DashbordScreen> {
  double? length = 500;
  final Profile profile;
  final String access_token;

  _DashbordScreenState({required this.access_token, required this.profile});

  void getheartColor() async {
    favoraites = await fetchFavoriteProducts(access_token);
  }

  void initState() {
    getheartColor();

    super.initState();
  }

  void update() {
    setState(() {
      favoraites;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('DASH $access_token');

    return Container(
      color: offWhite,
      child: ListView(
        children: [
          Divider(height: 20, color: offWhite),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SideBarBotton(),
              VerticalDivider(width: 40, color: offWhite),
              Column(
                children: [
                  Text('Delivered to:', style: TextStyle(color: yellow)),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 20,
                    width: 200,
                    child: Text(profile.address, style: TextStyle(color: grey)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 20,
                    width: 200,
                  ),
                ],
              ),
              VerticalDivider(width: 40, color: offWhite),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: yellow.withOpacity(0.2),
                      spreadRadius: 0.05,
                      blurRadius: 10,
                      offset: Offset(7, 7),
                    ),
                  ],
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: 50,
              ),
            ],
          ),
          Divider(color: offWhite, height: 25),
          Text(
            '   Our Sales : ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Divider(color: offWhite, height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Container(
              decoration: BoxDecoration(
                color: grey,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 170,
            ),
          ),
          Divider(color: offWhite, height: 25),
          Text(
            '   Our Stores : ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Container(
              height: 100,
              child: FutureBuilder(
                future: fetchStores(access_token),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<Stores> allStores = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allStores.length,
                      itemBuilder: (context, index) {
                        print('SSSSSSSSSSSSSSSSSSSS');
                        print(allStores[0].storeImage);

                        return GestureDetector(
                          child: StoreContainer(
                            storeImage: 'assets/images/n.jpg',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreproductsScreen(
                                  storeId: allStores[index].storeId,
                                  storeName: allStores[index].storeName,
                                  description: allStores[index].description,
                                  storeImage: allStores[index].storeImage,
                                  access_token: access_token,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: yellow),
                    );
                  }
                },
              ),
            ),
          ),
          Divider(color: offWhite, height: 15),
          Text(
            '   Popular Products : ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Divider(color: offWhite, height: 15),
          // عرض قائمة المنتجات
          Container(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FutureBuilder<List<ProductsModel>>(
                future: fetchProducts(access_token),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<ProductsModel> allproducts = snapshot.data!;

                    print(allproducts[1].image);
                    print(allproducts.length);

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (favoraites.isEmpty) {
                          allproducts[index].heartColor = grey;
                        } else {
                          for (var i = 0; i < favoraites.length; i++) {
                            if (allproducts[index].productName ==
                                    favoraites[i].productName &&
                                allproducts[index].storeId ==
                                    favoraites[i].storeId) {
                              allproducts[index].favoraiteId = favoraites[i]
                                  .productId
                                  .toString();
                              allproducts[index].heartColor = red;
                            }
                          }
                        }

                        return Dashcard(
                          productName: allproducts[index].productName,
                          storeName: allproducts[index].storeName,
                          price: allproducts[index].price,
                          description: allproducts[index].description,
                          productId: allproducts[index].productId,
                          quantity: allproducts[index].quantity,
                          storeId: allproducts[index].storeId,
                          heartColor: allproducts[index].heartColor,
                          access_token: access_token,
                          favoraiteId: allproducts[index].favoraiteId,
                        );
                      },
                      itemCount: allproducts.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: yellow),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
