import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gypsybook/models/world_model.dart';
import 'package:gypsybook/utils/const.dart';
import 'package:http/http.dart' as http;

class Worlds with ChangeNotifier {
  List<World> _items = [];

  List<World> get items {
    return [..._items];
  }

  World findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetContinents() async {
    final url = Uri.parse('${Constants.hostName}earth.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(json.decode(response.body));
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      final List<World> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(World(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
        ));
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addContinent(World product) async {
    final url = Uri.parse('${Constants.hostName}earth.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
        }),
      );
      final newProduct = World(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateContinent(
      String id, World newProduct, String title) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(Constants.hostName + '/courses/$title/$id.json');
      // final url =
      //     Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteContinent(
      BuildContext context, String id, String title) async {
    final url = Uri.parse(Constants.hostName + '/courses/$title/$id.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    World? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
