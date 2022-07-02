import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class World {
  final String? id;
  final String? title;
  final String? description;
  //final double price;
  final String? imageUrl;
  //bool isFavorite;

  World({
    this.id,
    this.title,
    this.description,
    //required this.price,
    this.imageUrl,
    // this.isFavorite = false,
  });
}
