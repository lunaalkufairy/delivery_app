import 'package:flutter/material.dart';
import 'package:delivery_app/constants/AppColors.dart';
import 'package:delivery_app/screens/App.dart';

class UiHelper {
  // دالة لعرض ديلوغ الدفع
  static void showPaymentDialog({
    required BuildContext context,
    required Function(String selectedPaymentMethod) onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        String? selectedPayment; // لتخزين الخيار المحدد

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: offWhite,
              title: Text(
                'Select Your Payment Method',
                style: TextStyleGeneral.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: Container(
                decoration: BoxDecoration(
                  color: offWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = 'Credit Card'; // نص متطابق
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: selectedPayment == 'Credit Card'
                                ? yellow.withOpacity(0.8)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: yellow.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.credit_card,
                                    color: selectedPayment == 'Credit Card'
                                        ? Colors.black
                                        : yellow,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Credit Card', // نص متطابق
                                    style: TextStyleGeneral.copyWith(
                                      color: selectedPayment == 'Credit Card'
                                          ? Colors.black
                                          : grey,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedPayment == 'Credit Card')
                                const Icon(Icons.check, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = 'Paypal'; // نص متطابق
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: selectedPayment == 'Paypal'
                                ? yellow.withOpacity(0.8)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: yellow.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    color: selectedPayment == 'Paypal'
                                        ? Colors.black
                                        : yellow,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Paypal', // نص متطابق
                                    style: TextStyleGeneral.copyWith(
                                      color: selectedPayment == 'Paypal'
                                          ? Colors.black
                                          : grey,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedPayment == 'Paypal')
                                const Icon(Icons.check, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPayment = 'Cash on Delivery'; // نص متطابق
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: selectedPayment == 'Cash on Delivery'
                                ? yellow.withOpacity(0.8)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: yellow.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: selectedPayment == 'Cash on Delivery'
                                        ? Colors.black
                                        : yellow,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Cash on Delivery', // نص متطابق
                                    style: TextStyleGeneral.copyWith(
                                      color:
                                          selectedPayment == 'Cash on Delivery'
                                          ? Colors.black
                                          : grey,
                                    ),
                                  ),
                                ],
                              ),
                              if (selectedPayment == 'Cash on Delivery')
                                const Icon(Icons.check, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyleGeneral.copyWith(color: grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedPayment != null) {
                      onConfirm(selectedPayment!); // استدعاء الدالة مع القيمة
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a payment method.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyleGeneral.copyWith(color: yellow),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showAlertWithList({
    required BuildContext context,
    required String title,
    required List<String> items,
    required Function(String) onItemSelected,
  }) {
    String? selectedItem;

    showDialog(
      context: context,
      barrierDismissible: false, //to stop close screen
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: offWhite,
              title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              content: Container(
                color: offWhite,
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedItem = items[index];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: selectedItem == items[index]
                                ? yellow.withOpacity(0.8)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: yellow.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                items[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: selectedItem == items[index]
                                      ? Colors.black
                                      : Colors.grey[800],
                                ),
                              ),
                              if (selectedItem == items[index])
                                Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 30,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // إغلاق بدون اختيار
                  },
                  child: Text("Cancel", style: TextStyleGeneral),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedItem != null) {
                      onItemSelected(selectedItem!); // تحديث قيمة الحقل
                      Navigator.pop(dialogContext); // إغلاق النافذة
                    }
                  },
                  child: Text("Confirm", style: TextStyleGeneral),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static void showAlert({
    required BuildContext context,
    required String title,
    required String content,
    String buttonText = 'OK',
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'calibri',
            fontWeight: FontWeight.bold,
            color: darkBlack,
            fontSize: 30,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            fontFamily: 'calibri',
            fontSize: 20,
            color: darkBlack,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontFamily: 'calibri',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: yellow,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
          ),
        ],
      ),
    );
  }

  static Widget MainTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: darkBlack,
      ),
    );
  }

  static Widget BigTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 50,
        fontWeight: FontWeight.bold,
        color: darkBlack,
      ),
    );
  }

  static Widget ProductTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkBlack,
      ),
    );
  }

  static Widget AppBarTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: darkBlack,
      ),
    );
  }

  static Widget subTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static Widget TextGrey(String title) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Sofia', fontSize: 20, color: grey),
    );
  }

  static Widget TextRed(String title) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Sofia', fontSize: 20, color: red),
    );
  }

  static Widget TextYellow(String title) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Sofia', fontSize: 16, color: yellow),
    );
  }

  static Widget DilogTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: darkBlack,
      ),
    );
  }

  static Widget buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 18, color: Colors.black54));
  }

  static TextStyle TextStyleGeneral = TextStyle(
    fontFamily: 'Sofia',
    fontSize: 18,
    color: darkBlack,
  );

  static TextStyle ButtonTitle = TextStyle(
    fontFamily: 'sofia',
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: offWhite,
  );

  static Widget BigTextGrey(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'calibri',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: grey,
      ),
    );
  }

  static Widget BigTextYellow(String title) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Sofia', fontSize: 23, color: yellow),
    );
  }

  static void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: darkBlack,
            fontFamily: 'calibri',
            fontSize: 15,
          ),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2), // مدة العرض
      ),
    );
  }
}
