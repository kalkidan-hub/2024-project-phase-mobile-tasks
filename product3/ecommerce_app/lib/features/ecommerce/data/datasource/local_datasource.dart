import '../models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<void> cacheProduct(ProductModel productModel);
  Future<void> cacheProducts(List<ProductModel> productModels);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(String id);
  Future<void> deleteProduct(String id);
}
