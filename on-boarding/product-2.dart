import 'dart:io';

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

class eCommerce {
  Map<String?, Product> products = {};

  // having a default product in the product store,

  void defaulting() {
    products['default'] = Product('', 0.0, "No product with this name");
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
  void edit(name, {new_name, price, description}) {
    if (new_name != "") {
      double? new_price = products[name]!.price;
      String? new_description = products[name]!.description;

      if (price != 0) {
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

// ... Product and eCommerce classes as before

void main() {
  print("Welcome to the eCommerce command-line App");
  print("you shall interact with the app using the action you want to take");
  print("view, viewall, edit and add  are the available actions");
  print("enjoy your stay :)");

  eCommerce manager = eCommerce();
  manager.defaulting();

  while (true) {
    stdout.write('> ');
    String? command = stdin.readLineSync()?.trim();

    if (command == null || command.isEmpty) continue;

    List<String> args = command.split(' ');
    String action = args[0];

    switch (action) {
      case 'add':
        if (args.length < 3) {
          print('Usage: add <name> <price> [description]');
          continue;
        }
        String name = args[1];
        double price = double.parse(args[2]);
        String? description = args.length > 3 ? args[3] : null;
        manager.add(Product(name, price, description));
        print('Product added successfully.');
        break;
      case 'view':
        if (args.length < 2) {
          print('Usage: view <name>');
          continue;
        }
        String name = args[1];
        Product? product = manager.view(name);
        if (product != null) {
          print(product.name);
          print(product.price);
          print(product.description);
        } else {
          print('Product not found.');
        }
        break;
      case 'viewall':
        for (Product product in manager.viewAll()) {
          if (product.name != '') {
            print(product.name);
            print(product.price);
            print(product.description);
          }
        }
        break;
      case 'edit':
        if (args.length < 2) {
          print('Usage: edit <name> [new_name] [price] [description]');
          continue;
        }
        String name = args[1];
        String? new_name = args.length > 2 ? args[2] : null;
        double? price = args.length > 3 ? double.parse(args[3]) : null;
        String? description = args.length > 4 ? args[4] : null;
        manager.edit(name,
            new_name: new_name, price: price, description: description);
        print('Product updated successfully.');
        break;
      case 'delete':
        if (args.length < 2) {
          print('Usage: delete <name>');
          continue;
        }
        String name = args[1];
        manager.delete(name);
        print('Product deleted successfully.');
        break;
      case 'exit':
        return;
      default:
        print('Invalid command. Try again.');
    }
  }
}
