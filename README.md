# Menggunakan Header
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/cat_fact.dart';
import '../providers/cat_login_provider.dart';

class CatFactProvider with ChangeNotifier {
  List<CatFact> _catFacts = [];

  List<CatFact> get catFacts => _catFacts;

  Future<void> fetchCatFacts(String token) async {
    final response = await http.get(
      Uri.parse(dotenv.env['CAT_FACTS_URL'] ?? ''),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

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

# State Management untuk handle login
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cat_login_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<CatLoginProvider>().login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                Navigator.pushNamed(context, '/cat-facts');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
