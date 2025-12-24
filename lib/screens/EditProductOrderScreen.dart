import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/backbotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/components/QuantityButton.dart';
import 'package:delivery_app/components/RatingStar.dart';
import 'package:delivery_app/logic/DetailProductManager.dart';
import 'package:delivery_app/model/Order.dart';
import 'package:delivery_app/model/OrderItem.dart';
import 'package:delivery_app/service/CartSevice.dart';
import 'package:delivery_app/service/OrderService.dart';

class EditProductOrderScreen extends StatefulWidget {
  final Order order;
  final OrderItem orderItem;
  final String token; // إضافة الـ token لتمريره إلى الخدمة

  const EditProductOrderScreen({
    Key? key,
    required this.orderItem,
    required this.order,
    required this.token,
  }) : super(key: key);

  @override
  _EditProductOrderScreenState createState() => _EditProductOrderScreenState();
}

class _EditProductOrderScreenState extends State<EditProductOrderScreen> {
  late DetailProductManager manager;
  bool isAddButtonError = false; // للتحكم بلون زر الإضافة عند الخطأ

  @override
  void initState() {
    super.initState();
    manager = DetailProductManager();
    manager.quantity =
        widget.orderItem.quantity; // تعيين الكمية المختارة ابتدائيًا
  }

  void _handleQuantityUpdate(bool isAdding) {
    setState(() {
      // في حالة الإضافة
      if (isAdding) {
        if (manager.quantity < widget.orderItem.pivotDetails!.quantity) {
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
    final product = widget.orderItem;
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
                UiHelper.ProductTitle(widget.orderItem.store.storeName),
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
            UiHelper.ProductTitle(widget.orderItem.product.name),
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
                  '\$${widget.orderItem.pivotDetails!.price}',
                  yellow,
                ),
                Column(
                  children: [
                    UiHelper.TextGrey(
                      'Available: ${widget.orderItem.pivotDetails!.quantity}', // الكمية المتاحة
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
                                  .orderItem
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
            UiHelper.TextGrey(widget.orderItem.pivotDetails!.description),
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
                final success = await OrderService.putyara(
                  token: widget.token,
                  orderId: widget.order.id,
                  productId: widget.orderItem.productId,
                  storeId: widget.orderItem.storeId,
                  quantity: manager.quantity, // ارسال الكمية المعدلة
                );
                print(widget.token);
                print(widget.order.id);
                print(widget.orderItem.productId);
                print(widget.orderItem.storeId);
                print(manager.quantity);
                if (success) {
                  // تحديث الشاشة السابقة لتنعكس التعديلات
                  Navigator.pop(
                    context,
                    manager.quantity,
                  ); // إرسال الكمية المعدلة
                } else {
                  UiHelper.showAlert(
                    context: context,
                    title: 'Error',
                    content: 'Failed to update the product. Please try again.',
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
