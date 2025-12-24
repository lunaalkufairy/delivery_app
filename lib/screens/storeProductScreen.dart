import 'package:flutter/material.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/components/dashCard.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/storeProducts.dart';
import 'package:delivery_app/service/getStoreProducts.dart';

class StoreproductsScreen extends StatelessWidget {
  final int storeId;
  final String storeName;
  final String description;
  final String storeImage;
  final String access_token;
  StoreproductsScreen({
    required this.storeId,
    required this.storeName,
    required this.description,
    required this.storeImage,
    required this.access_token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Divider(height: 20, color: offWhite),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Backbotton(),
              VerticalDivider(width: 85, color: offWhite),
              Container(
                width: 90,
                child: Text(
                  'Store',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              VerticalDivider(width: 85, color: offWhite),
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
          Divider(height: 40, color: offWhite),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey,
                  ),
                ),
                VerticalDivider(width: 20, color: offWhite),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(color: offWhite, height: 10),
                    Container(width: 200, height: 50, child: Text(description)),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: offWhite, height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Store Products : ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(height: 15, color: offWhite),
          Container(
            decoration: BoxDecoration(
              color: grey.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            width: double.infinity,
            height: 530,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
              child: FutureBuilder(
                future: fetchProductsByStore(access_token, storeId),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<Storeproducts> storeProducts = snapshot.data!;

                    return GridView.builder(
                      itemCount: storeProducts.length,
                      itemBuilder: (context, index) {
                        if (favoraites.isEmpty) {
                          storeProducts[index].heartColor = grey;
                        } else {
                          for (var i = 0; i < favoraites.length; i++) {
                            if (storeProducts[index].productName ==
                                    favoraites[i].productName &&
                                storeId == favoraites[i].storeId) {
                              storeProducts[index].favoraiteId = favoraites[i]
                                  .productId
                                  .toString();
                              storeProducts[index].heartColor = red;
                            }
                          }
                        }

                        return Dashcard(
                          productName: storeProducts[index].productName,
                          storeName: storeName,
                          price: storeProducts[index].price,
                          description: storeProducts[index].description,
                          productId: storeProducts[index].productId,
                          quantity: storeProducts[index].quantity,
                          storeId: storeId,
                          heartColor: storeProducts[index].heartColor,
                          access_token: access_token,
                          favoraiteId: storeProducts[index].favoraiteId,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 2,
                      ),
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
