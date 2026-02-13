import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late TextEditingController _searchController;
  String _searchQuery = 'Shoes';
  List<SearchProduct> searchResults = [];

  final List<SearchProduct> allProducts = [
    SearchProduct(
      id: 1,
      name: 'Watch',
      price: 40,
      image: 'assets/home_screen_image/watch.png',
      isFavorite: false,
      backgroundColor: Colors.red,
    ),
    SearchProduct(
      id: 2,
      name: 'Nike Shoes',
      price: 430,
      image: 'assets/home_screen_image/shoes.png',
      isFavorite: false,
      backgroundColor: Colors.grey,
    ),
    SearchProduct(
      id: 3,
      name: 'LG TV',
      price: 330,
      image: 'assets/home_screen_image/tv.png',
      isFavorite: false,
      backgroundColor: Colors.pink.shade200,
    ),
    SearchProduct(
      id: 4,
      name: 'Airpods',
      price: 333,
      image: 'assets/home_screen_image/airpods.png',
      isFavorite: false,
      backgroundColor: Colors.black,
    ),
    SearchProduct(
      id: 5,
      name: 'Jacket',
      price: 50,
      image: 'assets/home_screen_image/jacket.png',
      isFavorite: false,
      backgroundColor: Colors.black87,
    ),
    SearchProduct(
      id: 6,
      name: 'Hoodie',
      price: 400,
      image: 'assets/home_screen_image/hoodie.png',
      isFavorite: false,
      backgroundColor: Colors.blue,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: _searchQuery);
    _performSearch(_searchQuery);
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final results = allProducts
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  void _toggleFavorite(SearchProduct product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });

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

  void _addToCart(SearchProduct product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      searchResults = [];
    });
  }

  void _openFilters() async {
    final result = await Navigator.pushNamed(context, AppRoutes.filter);
    if (result != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Filters updated'),
          duration: Duration(milliseconds: 700),
          backgroundColor: Color(0xFF6C63FF),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchHeader(),
            if (searchResults.isNotEmpty) _buildResultsInfo(),
            searchResults.isEmpty
                ? _buildEmptyState()
                : _buildSearchResultsGrid(),
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
      title: const SizedBox.shrink(),
      centerTitle: true,
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                _searchQuery = value;
                _performSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: _clearSearch,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.grey, size: 18),
              ),
            ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _openFilters,
            child: const Icon(Icons.tune, color: Colors.grey, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Results for "$_searchQuery"',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            '${searchResults.length} Results Found',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6C63FF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for different keywords',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildSearchResultCard(searchResults[index]);
      },
    );
  }

  Widget _buildSearchResultCard(SearchProduct product) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.productDetails),
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
                  color: product.backgroundColor,
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

  Widget _buildFavoriteButton(SearchProduct product) {
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

  Widget _buildAddToCartButton(SearchProduct product) {
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
          icon: const Icon(Icons.search, color: Color(0xFF6C63FF)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined, color: Colors.grey[400]),
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

// Search Product Model
class SearchProduct {
  final int id;
  final String name;
  final double price;
  final String image;
  bool isFavorite;
  final Color backgroundColor;

  SearchProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.backgroundColor,
  });
}
