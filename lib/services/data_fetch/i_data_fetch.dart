import '../../../models/product.dart';

abstract class IDataFetch {
  Future<List<Product>> getProducts();
}
