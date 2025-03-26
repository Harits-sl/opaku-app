// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opaku_app/data/model/product.dart';

class ProductService {
  static Future<List<Product>?> fetchProducts() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    try {
      List<Product> listProducts = [];
      QuerySnapshot snapshot = await products.get();
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
        log('product: ${product.imageUrl}');
        listProducts.add(product);
      });
      return listProducts;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future fetchProductByID(String id) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    try {
      Product? itemProduct;
      QuerySnapshot snapshot = await products.where('id', isEqualTo: id).get();
      snapshot.docs.forEach((doc) {
        Product product = Product.fromMap(doc.data() as Map<String, dynamic>);
        log('product: ${product.imageUrl}');
        itemProduct = product;
      });
      return itemProduct;
    } catch (e) {
      print(e);
    }
    return null;

    // return users
    //     .add({
    //       'username': username,
    //       'email': email,
    //       'password': password,
    //     })
    //     .then((value) => print("User added successfully!"))
    //     .catchError((error) => print("Failed to add user: $error"));
  }
}
