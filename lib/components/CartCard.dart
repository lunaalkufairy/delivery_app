import 'package:flutter/material.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/CartModel.dart';

class CartCard extends StatelessWidget {
  final CartModel cartModel;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CartCard({
    Key? key,
    required this.cartModel,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: offWhite,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: yellow.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
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
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartModel.product.name.toString(),
                      style: UiHelper.TextStyleGeneral,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    UiHelper.TextGrey(cartModel.store.storeName.toString()),
                    const SizedBox(height: 4.0),
                    UiHelper.TextYellow('\$${cartModel.price}'),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      UiHelper.BigTextYellow('${cartModel.quantity}'),
                      const SizedBox(width: 5.0),
                      UiHelper.TextGrey('Items'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(textOfButton: 'Edit', onPressed: onEdit),
                ],
              ),
              const SizedBox(width: 8.0),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close, color: red, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
