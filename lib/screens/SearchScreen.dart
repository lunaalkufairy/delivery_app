import 'package:flutter/material.dart';
import 'package:delivery_app/components/SideBarBotton.dart';
import 'package:delivery_app/components/dashCard.dart';

import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/ProductList.dart';

import 'package:delivery_app/model/productsmodel.dart';
import 'package:delivery_app/screens/DashbordScreen.dart';

import 'package:delivery_app/service/getProducts.dart';

class SearchScreen extends StatefulWidget {
  final String access_token;
  const SearchScreen({required this.access_token});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState(access_token: access_token);
}

class _SearchScreenState extends State<SearchScreen> {
  final String access_token;
  _SearchScreenState({required this.access_token});
  List<ProductsModel> founds = [];

  List<ProductsModel> sea = [];
  void search(String keyword) async {
    sea = await fetchProducts(access_token);
    List<ProductsModel> result = [];
    if (keyword.isEmpty) {
      result = sea; // إذا كانت الكلمة فارغة، يتم عرض جميع المنتجات
    } else {
      result = sea
          .where(
            (item) =>
                item.productName.toLowerCase().contains(keyword.toLowerCase()),
          )
          .cast<ProductsModel>()
          .toList();
    }

    @override
    void initState() {
      founds = sea; // ربط القائمة الافتراضية
      super.initState();
    }

    setState(() {
      founds = result; // تحديث قائمة النتائج
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: offWhite,
        child: Column(
          children: [
            Divider(height: 76, color: offWhite),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SideBarBotton()],
              ),
            ),
            Divider(color: offWhite, height: 25),
            const SizedBox(
              width: double.infinity,
              child: Text(
                '   What Would You Like \n    To Search  : ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: offWhite, height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  return search(value); // البحث عند كتابة النص
                },
                cursorColor: yellow,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: yellow, width: 2),
                  ),
                  hintText: 'Find for a product',
                  hintStyle: TextStyle(color: offWhite, fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Divider(color: offWhite, height: 25),
            SizedBox(
              height: 496,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child:
                    founds
                        .isEmpty // إذا كانت القائمة فارغة
                    ? const Center(
                        child: Text(
                          'No Products Found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: founds.length,
                        itemBuilder: (context, index) {
                          if (favoraites.isEmpty) {
                            founds[index].heartColor = grey;
                          } else {
                            for (var i = 0; i < favoraites.length; i++) {
                              if (founds[index].productName ==
                                      favoraites[i].productName &&
                                  founds[index].storeId ==
                                      favoraites[i].storeId) {
                                founds[index].favoraiteId = favoraites[i]
                                    .productId
                                    .toString();
                                founds[index].heartColor = red;
                              }
                            }
                          }

                          return Dashcard(
                            productName: founds[index].productName,
                            storeName: founds[index].storeName,
                            price: founds[index].price,
                            description: founds[index].description,
                            productId: founds[index].productId,
                            quantity: founds[index].quantity,
                            storeId: founds[index].storeId,
                            access_token: access_token,
                            heartColor: founds[index].heartColor,
                            favoraiteId: founds[index].favoraiteId,
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 260,
                              crossAxisSpacing: 2,
                            ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
