import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CatImageProvider with ChangeNotifier {
  List<CatImage> _catImages = [];

  List<CatImage> get catImages => _catImages;

  Future<void> fetchCatImages() async {
    final response = await http.get(Uri.parse(dotenv.env['CAT_IMAGES_URL'] ?? ''));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> imagesJson = data;

      _catImages = imagesJson.map((json) => CatImage.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load cat images');
    }
  }
}
