import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cat_fact.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CatFactProvider with ChangeNotifier {
  List<CatFact> _catFacts = [];

  List<CatFact> get catFacts => _catFacts;

  Future<void> fetchCatFacts() async {
    final response = await http.get(Uri.parse(dotenv.env['CAT_FACTS_URL'] ?? ''));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> factsJson = data['data'];

      _catFacts = factsJson.map((json) => CatFact.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load cat facts');
    }
  }
}
