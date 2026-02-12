import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/filter_screen.dart';
import '../screens/home_screen.dart';
import '../screens/orderhistory_screen.dart';
import '../screens/productdetails_screen.dart';
import '../screens/productlist_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/searchresults_screen.dart';
import '../screens/setting_screen.dart';

class CheckoutArgs {
  final int items;
  final double subtotal;
  final double discount;
  final double deliveryCharges;
  final double total;

  const CheckoutArgs({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.deliveryCharges,
    required this.total,
  });
}

class AppRoutes {
  static const String home = '/';
  static const String productList = '/products';
  static const String productDetails = '/product-details';
  static const String searchResults = '/search-results';
  static const String filter = '/filter';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderHistory = '/orders';
  static const String profile = '/profile';
  static const String settingsRoute = '/settings';

  static const List<String> mainTabRoutes = <String>[
    home,
    searchResults,
    cart,
    profile,
  ];

  static void goToMainTab(BuildContext context, int index) {
    if (index < 0 || index >= mainTabRoutes.length) {
      return;
    }

    final String targetRoute = mainTabRoutes[index];
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute == targetRoute) {
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      targetRoute,
      (route) => route.settings.name == home,
    );
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
      case productList:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProductListScreen(),
        );
      case productDetails:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProductDetailsScreen(),
        );
      case searchResults:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchResultsScreen(),
        );
      case filter:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FilterScreen(),
        );
      case cart:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      case checkout:
        final CheckoutArgs? args = settings.arguments as CheckoutArgs?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CheckoutScreen(
            items: args?.items ?? 0,
            subtotal: args?.subtotal ?? 0,
            discount: args?.discount ?? 0,
            deliveryCharges: args?.deliveryCharges ?? 0,
            total: args?.total ?? 0,
          ),
        );
      case orderHistory:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const OrderHistoryScreen(),
        );
      case profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfileScreen(),
        );
      case settingsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SettingsScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
