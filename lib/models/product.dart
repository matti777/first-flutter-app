class Product {
  final int id;
  final String title;
  final String description;
  final int price;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price});

  @override
  String toString() {
    return 'Product title: $title, price: $price, description: $description';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
    );
  }
}
