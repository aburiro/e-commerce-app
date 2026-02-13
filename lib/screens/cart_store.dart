import 'order_store.dart';

class CartStore {
  static final List<CartItem> items = [];

  static void addItem(CartItem item) {
    final index = items.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      items[index].quantity += item.quantity;
    } else {
      items.add(item);
    }
  }

  static void removeItem(int index) {
    items.removeAt(index);
  }

  static void updateQuantity(int index, int qty) {
    if (qty <= 0) {
      items.removeAt(index);
    } else {
      items[index].quantity = qty;
    }
  }

  static double get subtotal {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  static void clear() {
    items.clear();
  }
}

class CartItem {
  final int id;
  final String name;
  final String brand;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
