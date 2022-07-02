import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gypsybook/models/country_model.dart';
import 'package:gypsybook/utils/const.dart';
import 'package:http/http.dart' as http;

class CountryProvider with ChangeNotifier{
  List<Country> _list = [];

  List<Country> get list {
    return [..._list];
  }
  Country findById(String id) {
    return _list.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetCountries() async {
    final url = Uri.parse('${Constants.hostName}country.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(json.decode(response.body));
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      final List<Country> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Country(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
        ));
      });

      _list = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addCountry(Country product) async {
    final url = Uri.parse('${Constants.hostName}country.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
        }),
      );
      final newProduct = Country(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateCountry(
      String id, Country newProduct, String title) async {
    final prodIndex = _list.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse('${Constants.hostName}/country/$title/$id.json');
      // final url =
      //     Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          }));
      _list[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteCountry(
      BuildContext context, String id, String title) async {
    final url = Uri.parse('${Constants.hostName}/country/$title/$id.json');
    final existingProductIndex = _list.indexWhere((prod) => prod.id == id);
    Country? existingProduct = _list[existingProductIndex];
    _list.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _list.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}