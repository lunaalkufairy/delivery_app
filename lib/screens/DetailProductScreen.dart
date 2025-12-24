import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/components/QuantityButton.dart';
import 'package:delivery_app/components/RatingStar.dart';
import 'package:delivery_app/components/StaticIconButton.dart';
import 'package:delivery_app/Animation/AnimatedIconButton.dart';
import 'package:delivery_app/helper/delets.dart';
import 'package:delivery_app/helper/post.dart';
import 'package:delivery_app/logic/DetailProductManager.dart';
import 'package:delivery_app/model/productsmodel.dart';

class DetailProductScreen extends StatefulWidget {
  final ProductsModel product;
  final String token; // إضافة الـ token لتمريره إلى الخدمة
  final int storeId; // إضافة الـ storeId لتمريره إلى الخدمة

  const DetailProductScreen({
    Key? key,
    required this.product,
    required this.token,
    required this.storeId,
  }) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState(
    product: product,
    storeId: storeId,
    token: token,
  );
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  final ProductsModel product;
  final String token;
  final int storeId;
  _DetailProductScreenState({
    required this.product,
    required this.token,
    required this.storeId,
  });
  late DetailProductManager manager;
  bool isAddButtonError = false;
  bool shouldAnimateOrderButton = false;
  bool isFavorite = false; // متغير لتتبع حالة المفضلة

  @override
  void initState() {
    super.initState();
    manager = DetailProductManager();

    // التحقق إذا كان المنتج موجودًا بالفعل في المفضلة
    isFavorite = manager.isFavorite(widget.product);
  }

  void _handleQuantityUpdate(bool isAdding) {
    setState(() {
      if (manager.quantity == 0) {
        isAddButtonError = false;
      }
      if (widget.product.quantity == 0) {
        isAddButtonError = true;
      }
      manager.updateQuantity(widget.product.quantity, isAdding);
      shouldAnimateOrderButton = manager.quantity > 0;
      isAddButtonError = false;
    });
  }

  void _handleAddToFavorite() async {
    if (product.heartColor == grey) {
      http.Response response = await posts(
        url: 'http://10.0.2.2:8000/api/v1/user/favorites/add-product',
        body: {
          'product_id': product.productId.toString(),
          'store_id': product.storeId.toString(),
        },
        token: token,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        setState(() {
          product.heartColor = red;
        });
      }
    } else if (product.heartColor == red) {
      http.Response response = await delets(
        url: 'http://10.0.2.2:8000/api/v1/user/favorites',
        body: {"favorite_id": product.favoraiteId},
        token: token,
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          product.heartColor = grey;
        });
      }
    }
  }

  Future<void> _handleAddToCart() async {
    try {
      final success = await manager.addToCart(
        product: widget.product,
        token: widget.token,
        storeId: widget.storeId,
      );

      setState(() {
        if (!success) {
          _triggerAddButtonError();
        } else {
          UiHelper.showSnackBar(
            context,
            'Product added to cart successfully!',
            offWhite,
          );
        }
      });
    } catch (e) {
      UiHelper.showSnackBar(context, 'Failed to add product to cart: $e', red);
    }
  }

  Future<void> _handleOrderProduct() async {
    if (manager.quantity == 0) {
      setState(() {
        isAddButtonError = true;
      });
      UiHelper.showSnackBar(context, 'Please select a quantity!', red);
      return;
    }

    // إيقاف الأنيميشن
    setState(() {
      shouldAnimateOrderButton = false;
    });

    // إظهار Dialog اختيار طريقة الدفع
    UiHelper.showPaymentDialog(
      context: context,
      onConfirm: (String selectedPaymentMethod) async {
        try {
          final success = await manager.orderProduct(
            product: widget.product,
            token: token,
            storeId: storeId,
            paymentMethod: selectedPaymentMethod,
          );

          if (success) {
            // تحديث الواجهة بعد إضافة الطلب بنجاح
            setState(() {
              product.quantity = product.quantity - manager.quantity;
              manager.quantity = 0;

              // إعادة تعيين الكمية إلى 0
            });
            UiHelper.showSnackBar(
              context,
              'Order placed successfully!',
              offWhite,
            );
          } else {
            UiHelper.showSnackBar(context, 'Failed to place order.', red);
          }
        } catch (e) {
          UiHelper.showSnackBar(context, 'Error placing order: $e', red);
        }
      },
    );
  }

  Future<void> _confirmOrder(String selectedPaymentMethod) async {
    Navigator.of(context).pop(); // إغلاق الـ Dialog

    try {
      final success = await manager.orderProduct(
        product: widget.product,
        token: token,
        storeId: storeId,
        paymentMethod: selectedPaymentMethod,
      );

      if (success) {
        UiHelper.showSnackBar(context, 'Order placed successfully!', offWhite);
      } else {
        UiHelper.showSnackBar(context, 'Failed to place order.', red);
      }
    } catch (e) {
      UiHelper.showSnackBar(context, 'Error placing order: $e', red);
    }
  }

  void _triggerAddButtonError() {
    setState(() {
      isAddButtonError = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isAddButtonError = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: offWhite,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 23.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Backbotton(),
                UiHelper.ProductTitle(product.storeName),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/images/map.png',
                height: 230,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20.0),
            UiHelper.ProductTitle(product.productName),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.star, color: yellow, size: 20),
                const SizedBox(width: 4.0),
                UiHelper.TextGrey('4.9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiHelper.subTitle('\$${product.price}', yellow),
                Column(
                  children: [
                    UiHelper.TextGrey(
                      'Available: ${product.quantity}', // إظهار الكمية المتاحة
                    ),
                    Row(
                      children: [
                        QuantityButton(
                          icon: Icons.remove,
                          isEnabled: manager.quantity > 0,
                          onTap: () => _handleQuantityUpdate(false),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${manager.quantity}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 8),
                        QuantityButton(
                          icon: Icons.add,
                          isEnabled: manager.quantity < widget.product.quantity,
                          onTap: () => _handleQuantityUpdate(true),
                          color: isAddButtonError ? red : yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            UiHelper.TextGrey(product.description),
            const SizedBox(height: 50.0),
            UiHelper.subTitle('Your Rating', darkBlack),
            RatingStars(
              rating: manager.userRating,
              totalStars: 5,
              onRate: (rating) {
                setState(() {
                  manager.updateRating(rating);
                });
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StaticIconButton(
                  icon: Icons.favorite,
                  iconName: 'Favorite',
                  color: product.heartColor,
                  onTap: _handleAddToFavorite,
                ),
                StaticIconButton(
                  iconName: 'Cart',
                  icon: Icons.shopping_cart,
                  color: yellow,
                  onTap: _handleAddToCart,
                ),
                AnimatedIconButton(
                  icon: Icons.shopping_cart,
                  glowColor: yellow,
                  iconName: 'Order It',
                  onTap: _handleOrderProduct,
                  shouldAnimate: shouldAnimateOrderButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
