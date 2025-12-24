import 'package:flutter/material.dart';
import 'package:delivery_app/components/SideBarBotton.dart';
import 'package:delivery_app/components/dashCard.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/favoraitesProducts.dart';
import 'package:delivery_app/service/getFavoraites.dart';

class FavoraiteScreen extends StatelessWidget {
  final String access_token;
  FavoraiteScreen({required this.access_token});
  Color? heartColor = red;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: offWhite,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Divider(height: 20, color: offWhite),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SideBarBotton(),
              VerticalDivider(width: 85, color: offWhite),
              Text(
                'Favoraites',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
          Divider(color: offWhite, height: 15),
          Container(
            height: 680,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FutureBuilder(
                future: fetchFavoriteProducts(access_token),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    List<FavoriteProduct> favoraites = snapshot.data!;

                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (favoraites.isEmpty) {
                          return Center(
                            child: Container(
                              height: 112,
                              width: 111,
                              color: yellow,
                            ),
                          );
                        }
                        return Dashcard(
                          productName: favoraites[index].productName,
                          storeName: favoraites[index].storeName,
                          price: favoraites[index].price,
                          description: favoraites[index].description,
                          productId: favoraites[index].productId,
                          quantity: favoraites[index].quantity,
                          storeId: favoraites[index].storeId,
                          access_token: access_token,
                          heartColor: heartColor!,
                          favoraiteId: favoraites[index].productId.toString(),
                        );
                      },
                      itemCount: favoraites.length,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
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
