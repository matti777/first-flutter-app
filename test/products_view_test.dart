import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_flutter_app/models/product.dart';
import 'package:first_flutter_app/views/products_view.dart';
import 'package:first_flutter_app/services/data_fetch/i_data_fetch.dart';
import 'package:first_flutter_app/injection.dart';

class MockDataFetch implements IDataFetch {
  static final allProducts = [
    Product(id: 1, title: 'Car', description: 'A small vehicle', price: 25000),
    Product(
        id: 2, title: 'Truck', description: 'A large vehicle', price: 50000),
  ];

  @override
  Future<List<Product>> getProducts() async {
    return allProducts;
  }
}

void main() {
  // Mock the data fetcher through dependency injection
  getIt.registerSingleton<IDataFetch>(MockDataFetch());

  testWidgets('Tests data fetch', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProductsListPage()));
    await tester.pumpAndSettle(); // Allow the list to render

    final textFinder = find.textContaining('Products');
    expect(textFinder, findsOneWidget);

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    final listView = listFinder.evaluate().single.widget as ListView;
    expect(listView.semanticChildCount, MockDataFetch.allProducts.length);
  });
}
