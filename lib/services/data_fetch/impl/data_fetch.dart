import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

import '../i_data_fetch.dart';
import '../../../models/product.dart';

@Injectable(as: IDataFetch)
class DataFetch implements IDataFetch {
  final log = Logger();

  @override
  Future<List<Product>> getProducts() async {
    log.d("fetching products");

    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<Product> products =
          (data['products'] as List).map((p) => Product.fromJson(p)).toList();
      log.d('fetched ${products.length} products');
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
