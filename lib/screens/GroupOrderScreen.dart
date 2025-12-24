// import 'package:flutter/material.dart';
// import 'package:delivery_app/components/OrderCard.dart';
// import 'package:delivery_app/components/backbotton.dart';
// import 'package:delivery_app/constants/AppColors.dart';
// import 'package:delivery_app/constants/UiHelper.dart';
// import 'package:delivery_app/model/Order.dart';
// import 'package:delivery_app/model/OrderItem.dart';
// import 'package:delivery_app/model/ProductList.dart';
// import 'package:delivery_app/service/OrderService.dart';

// class GroupOrderScreen extends StatefulWidget {
//   final String token;
//   final List<OrderItem> listorderItem; // قائمة المنتجات
//  final String message;
//   const GroupOrderScreen({Key? key, required this.listorderItem,required this.message,required this.token}) : super(key: key);

//   @override
//   _GroupOrderScreenState createState() => _GroupOrderScreenState();
// }

// class _GroupOrderScreenState extends State<GroupOrderScreen> {
//   late List<OrderItem> listProducts;

//   @override
//   void initState() {
//     super.initState();
//     listProducts = widget.listorderItem;
//   }
//  void _fetchOrders() {
//     setState(() {
//       listProducts = OrderService.fetchOrders(widget.token);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: offWhite,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(40.0),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Backbotton(),
//             ),
//           ),
//           Expanded(
//             child: listProducts.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No products available',
//                       style: TextStyle(
//                         color:grey,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: listProducts.length,
//                     itemBuilder: (context, index) {
//                       final productOrder = listProducts[index];
//                       return OrderCard(
//                        orderItem: productOrder,
//                         itemCount: productOrder.quantity,
//                         statusMessage:widget.message,
//                         onDelete:() async {
//                     final success =
//                         await OrderService.cancelOrder(widget.token, order.id);
//                     if (success) {
//                       UiHelper.showSnackBar(
//                         context,
//                         'Order canceled successfully',
//                         offWhite,
//                       );
//                       _fetchOrders(); // إعادة تحميل الطلبات بعد الإلغاء
//                     } else {
//                       UiHelper.showSnackBar(
//                           context, 'Failed to cancel order', red);
//                     }
//                   },
//                         onEdit: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) =>
//                           //         DetailProductScreen(product: orderItem, token: '', storeId: null,),
//                           //   ),
//                           // );
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
