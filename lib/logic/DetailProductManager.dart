import 'package:delivery_app/model/ProductList.dart';
import 'package:delivery_app/model/productsmodel.dart';
import 'package:delivery_app/service/CartSevice.dart';

class DetailProductManager {
  int quantity = 0;
  bool isFavorited = false;
  bool isInCart = false;
  int userRating = 0;

  // تحديث الكمية
  void updateQuantity(int availableQuantity, bool isAdding) {
    if (isAdding) {
      // زيادة الكمية إذا لم تتجاوز الكمية المتاحة
      if (quantity < availableQuantity) {
        quantity++;
      }
    } else {
      // تقليل الكمية إذا كانت الكمية أكبر من صفر
      if (quantity > 0) {
        quantity--;
      }
    }
  }

  // تحديث التقييم
  void updateRating(int rating) {
    userRating = rating;
  }

  // إضافة المنتج إلى السلة
  Future<bool> addToCart({
    required ProductsModel product,
    required String token,
    required int storeId,
  }) async {
    if (quantity > 0) {
      if (!isInCart) {
        try {
          await CartService.addToCart(
            token: token,
            productId: product.productId,
            storeId: storeId,
            quantity: quantity,
          );
          isInCart = true;
          return true;
        } catch (e) {
          print("Error adding product to cart: $e");
          return false;
        }
      }
    }
    return false;
  }

  // إضافة المنتج إلى المفضلة
  bool addToFavorite(ProductsModel product) {
    if (quantity > 0) {
      if (!isFavorited) {
        PublicListProductsFavorite.add(product);
        PublicListProductsFavoriteNotifier.value = List.from(
          PublicListProductsFavorite,
        );
        isFavorited = true;
        return true;
      }
    }
    return false;
  }

  // إزالة المنتج من المفضلة
  void removeFromFavorite(ProductsModel product) {
    PublicListProductsFavorite.remove(product);
    PublicListProductsFavoriteNotifier.value = List.from(
      PublicListProductsFavorite,
    );
    isFavorited = false;
  }

  // التحقق إذا كان المنتج في المفضلة
  bool isFavorite(ProductsModel product) {
    return PublicListProductsFavorite.contains(product);
  }

  // طلب المنتج
  Future<bool> orderProduct({
    required ProductsModel product,
    required String token,
    required int storeId,
    required String paymentMethod,
  }) async {
    if (quantity > 0) {
      final items = [
        {
          'product_id': product.productId,
          'quantity': quantity,
          'store_id': storeId,
        },
      ];
      try {
        await CartService.submitOrder(
          token: token,
          items: items,
          payment_method: paymentMethod,
        );
        return true;
      } catch (e) {
        print("Error placing order: $e");
        return false;
      }
    }
    return false;
  }
}
