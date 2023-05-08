import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../injection.dart';
import '../services/data_fetch/i_data_fetch.dart';
import '../models/product.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final dataFetch = getIt<IDataFetch>();
  final log = Logger();

  List<Product> products = <Product>[];

  @override
  void initState() {
    super.initState();

    dataFetch.getProducts().then((value) {
      setState(() {
        products = value;
      });
    }).onError((error, stackTrace) {
      log.e('failed to get products', error, stackTrace);
    });
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];
        return ListTile(
          title: Text('${item.title} (${item.price}€)'),
          leading: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Products (${products.length}):',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: createListView(),
          ),
        ],
      ),
    );
  }
}
