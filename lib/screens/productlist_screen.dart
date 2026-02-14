import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import 'cart_store.dart';
import 'product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<ProductItem> products = [
    ProductItem(
      id: 1,
      name: 'Watch',
      price: 40,
      image: 'assets/home_screen_image/watch.png',
      isFavorite: false,
      color: Colors.black,
    ),
    ProductItem(
      id: 2,
      name: 'Nike Shoes',
      price: 430,
      image: 'assets/home_screen_image/shoes.png',
      isFavorite: false,
      color: Colors.grey,
    ),
    ProductItem(
      id: 3,
      name: 'LG TV',
      price: 330,
      image: 'assets/home_screen_image/tv.png',
      isFavorite: false,
      color: Colors.black,
    ),
    ProductItem(
      id: 4,
      name: 'Airpods',
      price: 333,
      image: 'assets/home_screen_image/airpods.png',
      isFavorite: false,
      color: Colors.black,
    ),
    ProductItem(
      id: 5,
      name: 'Jacket',
      price: 50,
      image: 'assets/home_screen_image/jacket.png',
      isFavorite: false,
      color: Colors.grey,
    ),
    ProductItem(
      id: 6,
      name: 'Hoodie',
      price: 400,
      image: 'assets/home_screen_image/hoodie.png',
      isFavorite: false,
      color: Colors.grey,
    ),
    ProductItem(
      id: 7,
      name: 'T-Shirt',
      price: 25,
      image: 'assets/home_screen_image/jacket.png',
      isFavorite: false,
      color: Colors.black,
    ),
    ProductItem(
      id: 8,
      name: 'Sneakers',
      price: 120,
      image: 'assets/home_screen_image/shoes.png',
      isFavorite: false,
      color: Colors.grey,
    ),
  ];

  void _toggleFavorite(ProductItem product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });

    // Show a snackbar for feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          product.isFavorite
              ? '${product.name} added to favorites'
              : '${product.name} removed from favorites',
        ),
        duration: const Duration(milliseconds: 800),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  void _addToCart(ProductItem product) {
    CartStore.addItem(
      CartItem(
        id: product.id,
        name: product.name,
        brand: 'Brand',
        price: product.price.toDouble(),
        quantity: 1,
        image: product.image,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(products[index]);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: const Text(
        'Products',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.searchResults),
        ),
        IconButton(
          icon: const Icon(Icons.tune, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.filter),
        ),
      ],
      leadingWidth: 56,
    );
  }

  Widget _buildProductCard(ProductItem product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.productDetails,
        arguments: ProductDetailsArgs(
          product: Product(
            id: product.id,
            name: product.name,
            price: product.price,
            image: product.image,
            isFavorite: product.isFavorite,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              // 🔹 Image Section (flexible height)
              Expanded(
                child: Container(
                  color: _getProductBgColor(product.color),
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(product.image, fit: BoxFit.contain),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _buildFavoriteButton(product),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔹 Info Section (wraps content, no flex = no overflow)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // 💥 prevents overflow
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: _buildAddToCartButton(product),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(ProductItem product) {
    return GestureDetector(
      onTap: () => _toggleFavorite(product),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4),
          ],
        ),
        child: Icon(
          product.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: product.isFavorite ? Colors.red : Colors.grey[500],
          size: 18,
        ),
      ),
    );
  }

  Widget _buildAddToCartButton(ProductItem product) {
    return GestureDetector(
      onTap: () => _addToCart(product),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  Color _getProductBgColor(Color baseColor) {
    if (baseColor == Colors.black) {
      return Colors.black.withOpacity(0.05);
    } else if (baseColor == Colors.grey) {
      return Colors.grey[200] ?? Colors.grey;
    }
    return Colors.grey[100] ?? Colors.grey;
  }
}

// Product Model
class ProductItem {
  final int id;
  final String name;
  final int price;
  final String image;
  bool isFavorite;
  final Color color;

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.color,
  });
}
