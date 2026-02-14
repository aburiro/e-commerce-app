import 'package:ecommerce_app/screens/cart_store.dart';
import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import './order_store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Order> cartItems = [];

  double subtotal = 0;
  double discount = 4;
  double deliveryCharges = 2;

  @override
  void initState() {
    super.initState();
    _calculateSubtotal();
  }

  void _calculateSubtotal() {
    subtotal = 0;
    for (var item in cartItems) {
      subtotal += item.price * item.quantity;
    }
    setState(() {});
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity <= 0) {
      _removeItem(index);
      return;
    }
    setState(() {
      cartItems[index].quantity = newQuantity;
      _calculateSubtotal();
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      _calculateSubtotal();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(milliseconds: 800),
        backgroundColor: Color(0xFF6C63FF),
      ),
    );
  }

  double get total => subtotal - discount + deliveryCharges;

  void _proceedToCheckout() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(milliseconds: 800),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to checkout screen
    Navigator.pushNamed(
      context,
      AppRoutes.checkout,
      arguments: CheckoutArgs(
        items: cartItems.length,
        subtotal: subtotal,
        discount: discount,
        deliveryCharges: deliveryCharges,
        total: total,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildCartItems(),
                  _buildOrderSummary(),
                  _buildCheckoutButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Cart',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.more_vert, color: Colors.black),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          cartItems.length,
          (index) => _buildCartItemCard(cartItems[index] as CartItem, index),
        ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(item.image, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.brand,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.price}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _removeItem(index),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red[400],
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Quantity Controls
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _updateQuantity(index, item.quantity - 1),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 24,
                    child: Text(
                      item.quantity.toString().padLeft(2, '0'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _updateQuantity(index, item.quantity + 1),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Items', '${cartItems.length}'),
          const SizedBox(height: 12),
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(0)}'),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Discount',
            '-\$${discount.toStringAsFixed(0)}',
            isDiscount: true,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Delivery Charges',
            '\$${deliveryCharges.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(0)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.black : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isDiscount
                ? Colors.red[600]
                : isTotal
                ? Colors.black
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: _proceedToCheckout,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Check Out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: 1,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6C63FF),
      unselectedItemColor: Colors.grey[400],
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, color: Colors.grey[400]),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, color: Colors.grey[400]),
          label: '',
        ),

        BottomNavigationBarItem(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: Color(0xFF6C63FF),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.grey[400]),
          label: '',
        ),
      ],
      onTap: (index) {
        AppRoutes.goToMainTab(context, index);
      },
    );
  }
}
