import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/Order.dart';
import 'package:delivery_app/model/OrderItem.dart';

class GroupOrderCard extends StatelessWidget {
  final Order order;
  final List<OrderItem> listproduct; // قائمة المنتجات
  final VoidCallback onDelete; // Callback for delete
  final VoidCallback onEdit; // Callback for edit

  const GroupOrderCard({
    Key? key,
    required this.order,
    required this.listproduct,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // عدد المنتجات في القائمة
    final int itemCount = listproduct.length;

    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: yellow.withOpacity(0.8), // لون الظل
            spreadRadius: 4, // نشر الظل
            blurRadius: 10, // مدى التشويش
            offset: const Offset(0, 4), // الاتجاه (أعلى أو أسفل)
          ),
        ],
      ),
      child: Card(
        color: offWhite,
        elevation: 50, // جعل ظل الكارد نفسه شفافًا
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Icon(Icons.image, size: 70),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order', style: UiHelper.TextStyleGeneral),
                        UiHelper.TextGrey('Group of order'),
                        Row(
                          children: [
                            UiHelper.BigTextYellow(
                              '$itemCount',
                            ), // عدد المنتجات
                            const SizedBox(width: 5.0),
                            UiHelper.TextGrey('Product'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: UiHelper.BigTextYellow('\$${order.totalPrice}'),
                  ),
                  UiHelper.TextGrey(order.message),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(textOfButton: 'Cancel', onPressed: onDelete),
                  CustomButton(textOfButton: 'Edit Order', onPressed: onEdit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
