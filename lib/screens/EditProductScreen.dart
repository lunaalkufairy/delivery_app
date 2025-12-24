import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/components/QuantityButton.dart';
import 'package:delivery_app/components/RatingStar.dart';
import 'package:delivery_app/logic/DetailProductManager.dart';
import 'package:delivery_app/model/CartModel.dart';
import 'package:delivery_app/service/CartSevice.dart';

class EditProductScreen extends StatefulWidget {
  final dynamic cartModel;
  final String token; // إضافة الـ token لتمريره إلى الخدمة
  final int storeId; // إضافة الـ storeId لتمريره إلى الخدمة

  const EditProductScreen({
    Key? key,
    required this.cartModel,
    required this.token,
    required this.storeId,
  }) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late DetailProductManager manager;
  bool isAddButtonError = false; // للتحكم بلون زر الإضافة عند الخطأ

  @override
  void initState() {
    super.initState();
    manager = DetailProductManager();
    manager.quantity =
        widget.cartModel.quantity; // تعيين الكمية المختارة ابتدائيًا
  }

  void _handleQuantityUpdate(bool isAdding) {
    setState(() {
      // في حالة الإضافة
      if (isAdding) {
        if (manager.quantity < widget.cartModel.pivotDetails!.quantity) {
          manager.quantity++;
          isAddButtonError = false;
        } else {
          isAddButtonError = true; // عرض خطأ عند تجاوز الحد
        }
      }
      // في حالة الطرح
      else {
        if (manager.quantity > 0) {
          manager.quantity--;
          isAddButtonError = false;
        } else {
          // لا تفعل شيئًا إذا كانت الكمية 0
          isAddButtonError = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.cartModel;
    return Scaffold(
      backgroundColor: offWhite,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 23.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Backbotton(),
                UiHelper.ProductTitle(widget.cartModel.store.storeName),
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
            UiHelper.ProductTitle(widget.cartModel.product.name),
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
                UiHelper.subTitle(
                  '\$${widget.cartModel.pivotDetails!.price}',
                  yellow,
                ),
                Column(
                  children: [
                    UiHelper.TextGrey(
                      'Available: ${widget.cartModel.pivotDetails?.quantity}', // الكمية المتاحة
                    ),
                    Row(
                      children: [
                        QuantityButton(
                          icon: Icons.remove,
                          isEnabled:
                              manager.quantity >
                              0, // زر الطرح يعمل إذا كانت الكمية أكبر من 0
                          onTap: () => _handleQuantityUpdate(false),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${manager.quantity}', // الكمية المختارة من المستخدم
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 8),
                        QuantityButton(
                          icon: Icons.add,
                          isEnabled:
                              manager.quantity <
                              widget
                                  .cartModel
                                  .pivotDetails!
                                  .quantity, // زر الإضافة يعمل إذا كانت الكمية المختارة أقل من المتاحة
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
            UiHelper.TextGrey(widget.cartModel.pivotDetails!.description),
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
            const SizedBox(height: 60),
            const SizedBox(width: 60),
            CustomButton(
              textOfButton: 'Save',
              onPressed: () async {
                final success = await CartService.saveChanges(
                  token: widget.token,
                  productId: widget.cartModel.productId,
                  storeId: widget.storeId,
                  quantity: manager.quantity,
                );

                if (success) {
                  // تحديث الشاشة السابقة لتنعكس التعديلات
                  Navigator.pop(context, manager.quantity);
                } else {
                  UiHelper.showAlert(
                    context: context,
                    title: 'Error',
                    content:
                        'Failed to save product changes. Please try again.',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
