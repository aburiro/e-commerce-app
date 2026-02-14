class OrderStore {
  static final List<Order> orders = [];

  static void addOrder(Order order) {
    orders.add(order);
  }

  static List<Order> get active =>
      orders.where((o) => o.status == 'Active').toList();

  static List<Order> get completed =>
      orders.where((o) => o.status == 'Completed').toList();

  static List<Order> get cancelled =>
      orders.where((o) => o.status == 'Cancelled').toList();
}

class Order {
  final String id;
  final String productName;
  final String brand;
  final double price;
  final String image;
  final String status;
  final String orderDate;
  int quantity;
  Order({
    required this.id,
    required this.productName,
    required this.brand,
    required this.price,
    required this.image,
    required this.status,
    required this.orderDate,
    required this.quantity,
  });
}
