import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/OrderItem.dart';
import 'package:delivery_app/model/productsmodel.dart';

class OrderCard extends StatelessWidget {
  final OrderItem orderItem;
  final int itemCount;
  final String statusMessage;
  final VoidCallback onDelete; // Callback لحذف المنتج
  final VoidCallback onEdit; // Callback للتعديل

  const OrderCard({
    Key? key,
    required this.orderItem,
    required this.itemCount,
    required this.statusMessage,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset(
                      'assets/images/gluvs.jpg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderItem.product.name,
                          style: UiHelper.TextStyleGeneral,
                        ),
                        UiHelper.TextGrey(orderItem.store.storeName),
                        Row(
                          children: [
                            UiHelper.BigTextYellow(
                              '${orderItem.quantity.toString()}',
                            ),
                            const SizedBox(width: 5.0),
                            UiHelper.TextGrey('Items'),
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
                  UiHelper.BigTextYellow('\$${orderItem.price}'),
                  UiHelper.TextGrey(statusMessage),
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
