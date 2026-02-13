class Product {
  final int id;
  final String name;
  final int price;
  final String image;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });
}

class ProductDetailsArgs {
  final Product product;

  ProductDetailsArgs({required this.product});
}
