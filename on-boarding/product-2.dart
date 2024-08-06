class Product {
  String? name;
  String? description;
  double? price;

  // setter
  Product(String name, double price, [String? description]) {
    this.name = name;
    this.price = price;
    this.description = description;
  }
}

class ProductManager {
  Map<String?, Product> products = {};

  // having a default product in the product store,

  void defaulting() {
    products['default'] = Product('name', 0.0, "No product with this name");
  }

  // add a new product
  void add(Product product) {
    products[product.name] = product;
  }

  // view all products
  Iterable viewAll() {
    return this.products.values;
  }

  // view a single product
  Product? view(String name) {
    if (products.containsKey(name)) {
      return products[name];
    }
    return products['default'];
  }

  // edit a product
  void edit(name, [new_name, price, description]) {
    if (new_name != null) {
      double? new_price = products[name]!.price;
      String? new_description = products[name]!.description;

      if (price != null) {
        new_price = price;
      }
      if (description != null) {
        new_description = description;
      }

      Product product = Product(new_name, new_price!, new_description);
      products[new_name] = product;
      products.remove(name);
    } else {
      Product? product = products[name];
      if (price != null) {
        product!.price = price;
      }
      if (description != null) {
        product!.description = description;
      }
    }
  }

  // delete a product
  void delete(name) {
    products.remove(name);
  }
}
