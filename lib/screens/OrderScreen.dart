import 'package:flutter/material.dart';
import 'package:delivery_app/components/GroupOrderCard.dart';
import 'package:delivery_app/components/HistoryCard.dart';
import 'package:delivery_app/components/HistoryGroupCard.dart';
import 'package:delivery_app/components/OrderCard.dart';
import 'package:delivery_app/components/SideBarBotton.dart';
import 'package:delivery_app/components/TabButton.dart';
import 'package:delivery_app/constants/UiHelper.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/model/Order.dart';
import 'package:delivery_app/screens/EditProductOrderScreen.dart';

import 'package:delivery_app/service/OrderService.dart';

class OrdersScreen extends StatefulWidget {
  final String token;
  const OrdersScreen({Key? key, required this.token}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isOrdersTab = true;
  late Future<List<Order>> _ordersList;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() {
    setState(() {
      _ordersList = OrderService.fetchOrders(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: offWhite,
      child: Column(
        children: [
          const SizedBox(height: 60.0),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(21.0),
                child: SideBarBotton(),
              ),
              Row(
                children: [
                  UiHelper.AppBarTitle('YOUR ORDERS '),
                  Icon(Icons.shopping_cart, color: darkBlack, size: 30),
                ],
              ),
              const SizedBox(width: 48),
            ],
          ),
          // Tabs (Orders / History)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TabButton(
                    icon: Icons.shopping_cart,
                    text: 'Orders',
                    isSelected: _isOrdersTab,
                    onTap: () {
                      setState(() {
                        _isOrdersTab = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TabButton(
                    icon: Icons.history,
                    text: 'History',
                    isSelected: !_isOrdersTab,
                    onTap: () {
                      setState(() {
                        _isOrdersTab = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Orders or History List
          Expanded(
            child: FutureBuilder<List<Order>>(
              future: _ordersList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No orders available'));
                } else {
                  return _isOrdersTab
                      ? _buildOrdersList(snapshot.data!)
                      : _buildHistoryList(snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Orders List
  Widget _buildOrdersList(List<Order> orders) {
    final activeOrders = orders
        .where(
          (order) =>
              order.message != 'canceled' && order.message != 'delivered',
        )
        .toList();

    return activeOrders.isEmpty
        ? Center(
            child: Text(
              'No active orders available',
              style: TextStyle(
                color: darkBlack,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : ListView.builder(
            itemCount: activeOrders.length,
            itemBuilder: (context, index) {
              final order = activeOrders[index];

              if (order.storeid == null || order.storeid == 0) {
                return GroupOrderCard(
                  order: order,
                  listproduct: order.orderItems,
                  onDelete: () async {
                    final success = await OrderService.cancelOrder(
                      widget.token,
                      order.id,
                    );
                    if (success) {
                      UiHelper.showSnackBar(
                        context,
                        'Order canceled successfully',
                        offWhite,
                      );
                      _fetchOrders(); // إعادة تحميل الطلبات بعد الإلغاء
                    } else {
                      UiHelper.showSnackBar(
                        context,
                        'Failed to cancel order',
                        red,
                      );
                    }
                  },
                  onEdit: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => GroupOrderScreen(
                    //       token: widget.token,
                    //       listorderItem: order.orderItems,
                    //       message: order.message,
                    //     ),
                    //   ),
                    // );
                  },
                );
              } else {
                return OrderCard(
                  orderItem: order.orderItems.first,
                  itemCount: order.orderItems.length,
                  statusMessage: order.message,
                  onDelete: () async {
                    final success = await OrderService.cancelOrder(
                      widget.token,
                      order.id,
                    );
                    if (success) {
                      UiHelper.showSnackBar(
                        context,
                        'Order canceled successfully',
                        offWhite,
                      );
                      _fetchOrders(); // إعادة تحميل الطلبات بعد الإلغاء
                    } else {
                      UiHelper.showSnackBar(
                        context,
                        'Failed to cancel order',
                        red,
                      );
                    }
                  },
                  onEdit: () async {
                    final updatedQuantity = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductOrderScreen(
                          order: order,
                          token: widget.token,
                          orderItem: order.orderItems.first,
                        ),
                      ),
                    );

                    if (updatedQuantity != null) {
                      setState(() {
                        orders[index].orderItems[index].quantity =
                            updatedQuantity; // تحديث الكمية
                      });

                      UiHelper.showSnackBar(
                        context,
                        'Product updated successfully',
                        offWhite,
                      );

                      // تحديث السلة من الخادم للتأكد من التزامن
                      OrderService.fetchOrders(widget.token);
                    }
                  },
                );
              }
            },
          );
  }

  // History List
  Widget _buildHistoryList(List<Order> orders) {
    final historyOrders = orders
        .where(
          (order) =>
              order.message == 'canceled' || order.message == 'delivered',
        )
        .toList();

    return historyOrders.isEmpty
        ? Center(
            child: Text(
              'No cancelled or delivered orders in history',
              style: UiHelper.TextStyleGeneral,
            ),
          )
        : ListView.builder(
            itemCount: historyOrders.length,
            itemBuilder: (context, index) {
              final order = historyOrders[index];

              if (order.storeid == null || order.storeid == 0) {
                return HistoryGroupCard(
                  order: order,
                  listproduct: order.orderItems,
                );
              } else {
                return HistoryCard(
                  orderItem: order.orderItems.first,
                  itemCount: order.orderItems.length,
                  orderId: order.id.toString(),
                  statusMessage: order.message,
                );
              }
            },
          );
  }
}
