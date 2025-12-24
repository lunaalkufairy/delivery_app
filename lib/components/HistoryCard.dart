import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/OrderItem.dart';

class HistoryCard extends StatelessWidget {
  final OrderItem orderItem;
  final int itemCount;
  final String orderId;
  final String statusMessage;

  const HistoryCard({
    Key? key,
    required this.orderItem,
    required this.itemCount,
    required this.orderId,
    required this.statusMessage,
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
                    child: Image.asset(
                      'assets/images/gluvs.jpg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, size: 70);
                      },
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
                        UiHelper.TextGrey(
                          orderItem.store.storeName ?? 'Unknown Store',
                        ),
                        Row(
                          children: [
                            UiHelper.BigTextYellow('$itemCount'),
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
                  Text(
                    '\$${orderItem.price.toStringAsFixed(2)}',
                    style: UiHelper.TextStyleGeneral,
                  ),
                  UiHelper.TextRed(statusMessage),
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
