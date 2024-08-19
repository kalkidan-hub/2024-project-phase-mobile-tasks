import '../models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<void> cacheProduct(ProductModel product);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(String id);
}
