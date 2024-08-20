import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> viewAllProduct();
  Future<ProductModel> viewAProduct(String id);
  Future<ProductModel> createProduct(ProductModel productModel);
  Future<ProductModel> updateProduct(ProductModel productModel);
  Future<ProductModel> deleteProduct(String id);
}
