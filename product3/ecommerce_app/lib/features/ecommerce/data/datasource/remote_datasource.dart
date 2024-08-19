import '../../domain/entities/product.dart';

abstract class ProductRemoteDatasource {
  Future<Product> viewAllProduct();
  Future<Product> viewAProduct(int id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Product> deleteProduct(int id);
}
