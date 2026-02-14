import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import './product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;
  int _selectedNavIndex = 0;

  final List<Map<String, String>> bannerSlides = [
    {
      'title': 'Get Winter Discount',
      'subtitle': '20% Off',
      'description': 'For Children',
      'image': 'assets/home_screen_image/child_image.png',
    },
    {
      'title': 'Summer Sale',
      'subtitle': '30% Off',
      'description': 'On All Items',
      'image': 'assets/home_screen_image/child_image.png',
    },
  ];

  final List<Product> featuredProducts = [
    Product(
      id: 1,
      name: 'Watch',
      price: 40,
      image: 'assets/home_screen_image/watch.png',
      isFavorite: false,
    ),
    Product(
      id: 2,
      name: 'Nike Shoes',
      price: 430,
      image: 'assets/home_screen_image/shoes.png',
      isFavorite: false,
    ),
    Product(
      id: 3,
      name: 'Airpods',
      price: 333,
      image: 'assets/home_screen_image/airpods.png',
      isFavorite: false,
    ),
  ];

  final List<Product> popularProducts = [
    Product(
      id: 4,
      name: 'LG TV',
      price: 330,
      image: 'assets/home_screen_image/tv.png',
      isFavorite: false,
    ),
    Product(
      id: 5,
      name: 'Hoodie',
      price: 50,
      image: 'assets/home_screen_image/hoodie.png',
      isFavorite: false,
    ),
    Product(
      id: 6,
      name: 'Jacket',
      price: 400,
      image: 'assets/home_screen_image/jacket.png',
      isFavorite: false,
    ),
  ];

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });

    AppRoutes.goToMainTab(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Bar Spacing
            SizedBox(height: MediaQuery.of(context).padding.top),

            // Header with User Info
            _buildHeader(),

            // Search Bar
            _buildSearchBar(),

            // Banner Slider
            _buildBannerSlider(),

            // Banner Indicators
            _buildBannerIndicators(),

            // Featured Section
            _buildFeaturedSection(),

            // Featured Products Grid
            _buildProductGrid(featuredProducts),

            // Most Popular Section
            _buildMostPopularSection(),

            // Popular Products Grid
            _buildProductGrid(popularProducts),

            SizedBox(height: 80), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User Profile
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: const AssetImage(
                    'assets/home_screen_image/user_profile.png',
                  ),
                ),
              ),

              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello!',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    'Jameel Ahmed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Notification Icon
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              30,
            ), // Circular shape for the button
            elevation: 0, // Ensures the background stays clean
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined),
              // Moved the primary purple color here so it applies correctly
              color: const Color(0xFF6C63FF),

              // 1. Highlight Color: The INSTANT millisecond response color
              highlightColor: const Color.fromARGB(
                255,
                178,
                178,
                184,
              ).withOpacity(0.1),

              // 2. Splash Color: The smooth ripple effect
              splashColor: const Color.fromARGB(
                255,
                54,
                54,
                56,
              ).withOpacity(0.2),

              // 3. Splash Radius: Keeps the effect tight and professional
              splashRadius: 24,

              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.orderHistory),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        readOnly: true,
        onTap: () => Navigator.pushNamed(context, AppRoutes.searchResults),
        decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildBannerSlider() {
    final slide = bannerSlides[_currentBannerIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF5A52D5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Banner Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slide['title'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        slide['subtitle'] ?? '',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        slide['description'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // Illustration Placeholder
                  Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        slide['image'] ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          bannerSlides.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == _currentBannerIndex
                    ? const Color(0xFF6C63FF)
                    : Colors.grey[300],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Featured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.productList),
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMostPopularSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Most Popular',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.productList),
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.productDetails,
        arguments: ProductDetailsArgs(product: product),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(product.image, fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavorite(product),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite
                              ? Colors.red
                              : Colors.grey[400],
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(product.name),
          Text('\$${product.price}'),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedNavIndex,
      onTap: _onBottomNavTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF6C63FF),
      unselectedItemColor: Colors.grey[400],
      elevation: 8,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: _selectedNavIndex == 0
                ? const Color(0xFF6C63FF)
                : Colors.grey[400],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: _selectedNavIndex == 1
                ? const Color(0xFF6C63FF)
                : Colors.grey[400],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: _selectedNavIndex == 2
                ? const Color(0xFF6C63FF)
                : Colors.grey[400],
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: _selectedNavIndex == 3
                ? const Color(0xFF6C63FF)
                : Colors.grey[400],
          ),
          label: '',
        ),
      ],
    );
  }
}
