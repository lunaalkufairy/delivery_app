// HistoryGroupCard
import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/Order.dart';
import 'package:delivery_app/model/OrderItem.dart';

class HistoryGroupCard extends StatelessWidget {
  final Order order;
  final List<OrderItem> listproduct;

  const HistoryGroupCard({
    Key? key,
    required this.order,
    required this.listproduct,
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
            color: yellow.withOpacity(0.8),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        color: offWhite,
        elevation: 50,
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
                            UiHelper.BigTextYellow('${listproduct.length}'),
                            const SizedBox(width: 5.0),
                            UiHelper.TextGrey('Product'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // UiHelper.TextYellow('#${order.id}'),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${order.totalPrice}',
                    style: UiHelper.TextStyleGeneral,
                  ),
                  UiHelper.TextRed(order.message),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
