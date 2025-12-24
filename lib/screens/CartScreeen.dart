import 'package:flutter/material.dart';
import 'package:delivery_app/components/CartCard.dart';
import 'package:delivery_app/components/CustomButton.dart';
import 'package:delivery_app/components/SideBarBotton.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/model/CartResponse.dart';
import 'package:delivery_app/screens/EditProductScreen.dart';
import 'package:delivery_app/service/CartSevice.dart';

class CartScreen extends StatefulWidget {
  final String token;
  const CartScreen({Key? key, required this.token}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<CartResponse> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = CartService.fetchCartProducts(widget.token);
  }

  Map<String, double> calculateOrderSummary(CartResponse cartResponse) {
    // معالجة الحالة عندما تكون السلة فارغة
    double subtotal = cartResponse.items.isEmpty
        ? 0.0
        : cartResponse.totalPrice.toDouble();
    double deliveryFee = cartResponse.items.isEmpty ? 0.0 : 15.00;
    double total = subtotal + deliveryFee;

    return {'subtotal': subtotal, 'deliveryFee': deliveryFee, 'total': total};
  }

  Widget buildCartList(CartResponse cartResponse) {
    if (cartResponse.items.isEmpty) {
      return Center(child: UiHelper.TextGrey('No products in cart '));
    }

    return ListView.builder(
      itemCount: cartResponse.items.length,
      itemBuilder: (context, index) {
        final cartItem = cartResponse.items[index];
        return CartCard(
          cartModel: cartItem,
          onDelete: () async {
            try {
              await CartService.removeFromCart(
                token: widget.token,
                IdCart: cartItem.id,
              );

              // إزالة العنصر محليًا
              setState(() {
                cartResponse.items.removeAt(index);
              });

              // عرض رسالة النجاح
              UiHelper.showSnackBar(
                context,
                'Product removed successfully',
                offWhite,
              );

              // تحديث البيانات من الخادم للتأكد من التزامن
              _cartFuture = CartService.fetchCartProducts(widget.token);
            } catch (e) {
              UiHelper.showSnackBar(
                context,
                'Failed to remove product: $e',
                offWhite,
              );
            }
          },
          onEdit: () async {
            final updatedQuantity = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  cartModel: cartItem,
                  token: widget.token,
                  storeId: cartItem.storeId,
                ),
              ),
            );

            if (updatedQuantity != null) {
              setState(() {
                cartResponse.items[index].quantity =
                    updatedQuantity; // تحديث الكمية
              });

              UiHelper.showSnackBar(
                context,
                'Product updated successfully',
                offWhite,
              );

              // تحديث السلة من الخادم للتأكد من التزامن
              _cartFuture = CartService.fetchCartProducts(widget.token);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CartResponse>(
      future: _cartFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No cart items'));
        }

        final cartResponse = snapshot.data!;
        final orderSummary = calculateOrderSummary(cartResponse);

        return Container(
          color: offWhite,
          child: Column(
            children: [
              const SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(21.0),
                    child: SideBarBotton(),
                  ),
                  Row(
                    children: [
                      UiHelper.AppBarTitle('YOUR CART '),
                      Icon(Icons.shopping_cart, color: darkBlack, size: 30),
                    ],
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              Expanded(child: buildCartList(cartResponse)),
              buildOrderSummary(orderSummary),
            ],
          ),
        );
      },
    );
  }

  Widget buildOrderSummary(Map<String, double> orderSummary) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: offWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: yellow.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSummaryRow(
                'Subtotal',
                '\$${orderSummary['subtotal']!.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8.0),
              buildSummaryRow(
                'Delivery',
                '\$${orderSummary['deliveryFee']!.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 8.0),
              buildSummaryRow(
                'Total',
                '\$${orderSummary['total']!.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Center(
                  child: CustomButton(
                    textOfButton: 'Order it',
                    onPressed: () async {
                      try {
                        // Fetch cart data for submission
                        final cartResponse = await _cartFuture;

                        if (cartResponse.items.isEmpty) {
                          UiHelper.showSnackBar(
                            context,
                            'Cart is empty!',
                            offWhite,
                          );
                          return;
                        }

                        // عرض الديالوج لاختيار طريقة الدفع
                        UiHelper.showPaymentDialog(
                          context: context,
                          onConfirm: (selectedPaymentMethod) async {
                            try {
                              // Prepare cart items for submission
                              final orderItems = cartResponse.items.map((item) {
                                return {
                                  'product_id': item.productId,
                                  'store_id': item.storeId,
                                  'quantity': item.quantity,
                                };
                              }).toList();

                              // Submit order with the selected payment method
                              await CartService.submitOrder(
                                token: widget.token,
                                items: orderItems,
                                payment_method: selectedPaymentMethod,
                              );

                              // Clear the cart after successful submission
                              await CartService.clearCart(token: widget.token);

                              // Update the cart UI
                              setState(() {
                                _cartFuture = CartService.fetchCartProducts(
                                  widget.token,
                                );
                              });

                              // Show success message
                              UiHelper.showSnackBar(
                                context,
                                'Order placed successfully using $selectedPaymentMethod!',
                                offWhite,
                              );
                            } catch (e) {
                              // Handle errors during submission or clearing cart
                              UiHelper.showSnackBar(
                                context,
                                'Failed to place order: $e',
                                offWhite,
                              );
                            }
                          },
                        );
                      } catch (e) {
                        // Handle errors fetching cart
                        UiHelper.showSnackBar(
                          context,
                          'Failed to fetch cart: $e',
                          offWhite,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiHelper.TextGrey(label),
        Text(value, style: UiHelper.TextStyleGeneral),
      ],
    );
  }
}
